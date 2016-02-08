module Rscratch
  class ExceptionLog < ActiveRecord::Base

    if Rails::VERSION::MAJOR == 3
      attr_accessible :backtrace, :client_ip, :description, :exception_id, :parameters, :request_method, :request_url, :status, :user_agent
    end    
    ### => Model Relations
    belongs_to :exception

    ### => Defining statuses
    STATUS = %w(new under_development resolved)

    ### => Model Validations
    validates :exception_id, presence: true
    validates :status, presence: true, :inclusion => {:in => STATUS}

    ### => Model Callbacks
    after_create :calculate_log_count

    # => Dynamic methods for log statuses
    STATUS.each do |status|
      define_method "#{status}?" do
        self.status == status
      end
    end

    ### => Model Scopes
    scope :by_exception, lambda {|exc_id|where(["exception_id=?", exc_id])}                      
    scope :unresolved_exceptions, lambda {|last_id|where(["id >?", last_id])}                      
    scope :resolved, lambda {where(["status=?", "resolved"])}                      
    
    def start_development!
      update_attribute(:status, 'under_development')
    end

    def resolve!
      update_attribute(:status, 'resolved')
    end
    
    # Sets Log instance attributes.
    def self.set_attributes_for exc, request
      self.description    = exc.inspect,
      self.backtrace      = exc.backtrace.join("\n"),
      self.request_url    = request.original_url,
      self.request_method = request.request_method,
      self.parameters     = request.filtered_parameters,
      self.user_agent     = request.user_agent,
      self.client_ip      = request.remote_ip,
      self.status         = "new"   
    end    
    
    def log_count exception_id
      ExceptionLog.by_exception(exception_id).count
    end

    def last_resolved exception_id
      ExceptionLog.by_exception(exception_id).resolved.last
    end    
    
    def new_log_count exception_id
      _last_resolved = last_resolved exception_id
      _new_count = _last_resolved.present? ? ExceptionLog.by_exception(exception_id).unresolved_exceptions(_last_resolved.id).count : log_count(exception_id)
    end

    private

    def calculate_log_count
      _log_count = log_count self.exception_id
      _new_count = new_log_count self.exception_id

      # _exception_logs = ExceptionLog.by_exception(self.exception_id)
      # _last_resolved = _exception_logs.resolved.last
      # _new_logs = _last_resolved.present? ? (ExceptionLog.by_exception(self.exception_id).unresolved_exceptions(_last_resolved.id)) : _exception_logs
      self.exception.update_attributes(:total_occurance_count=>_log_count, :new_occurance_count=>_new_count)
    end  
  end
end
