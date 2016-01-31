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
    after_create :calculate_exception_count

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
    
    def development!
      update_attribute(:status, 'under_development')
    end

    def resolve!
      update_attribute(:status, 'resolved')
    end
    
    private

    def calculate_exception_count
      _exception_logs = ExceptionLog.by_exception(self.exception_id)
      _last_resolved = _exception_logs.resolved.last
      _new_logs = _last_resolved.present? ? (ExceptionLog.unresolved_exceptions(_last_resolved.id)) : _exception_logs
      self.exception.update_attributes(:total_occurance_count=>_exception_logs.count, :new_occurance_count=>_new_logs.count)
    end  
  end
end
