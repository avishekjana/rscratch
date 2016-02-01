module Rscratch
  class Exception < ActiveRecord::Base
    
    if Rails::VERSION::MAJOR == 3
      attr_accessible :action, :app_environment, :controller, :exception, :message, :new_occurance_count, :total_occurance_count, :status
    end
    
    STATUS = %w(new under_development resolved)

    ### => Model Relations
    has_many :exception_logs, :dependent => :destroy

    ### => Model Validations
    validates :exception       , presence: true
    validates :message         , presence: true
    validates :controller      , presence: true
    validates :action          , presence: true
    validates :app_environment , presence: true
    validates :status          , presence: true, :inclusion => {:in => STATUS}
                      
    ### => Model Scopes
    scope :by_exception, lambda {|exc|where(["exception=?", exc])}                      
    scope :by_message, lambda {|msg|where(["message=?", msg])}                      
    scope :by_controller, lambda {|con|where(["controller=?", con])}                      
    scope :by_action, lambda {|act|where(["action=?", act])}                      
    scope :by_environment, lambda {|env|where(["app_environment=?", env])}   
    scope :by_status, lambda {|status|where(["status=?", status])}   

    # => Dynamic methods for exception statuses
    STATUS.each do |status|
      define_method "#{status}?" do
        self.status == status
      end
    end

    # Log an exception
    def self.log(exc,request) 
      _exception = self.find_or_create(exc,request.filtered_parameters["controller"].camelize,request.filtered_parameters["action"],Rails.env.camelize)
      _log = ExceptionLog.new(
                                  :description         => exc.inspect,
                                  :backtrace           => exc.backtrace.join("\n"),
                                  :request_url         => request.original_url,
                                  :request_method      => request.request_method,
                                  :parameters          => request.filtered_parameters,
                                  :user_agent          => request.user_agent,
                                  :client_ip           => request.remote_ip,
                                  :status              => "new")
      _exception.exception_logs << _log
      return _exception
    end

    # Log unique exceptions
    def self.find_or_create exc,_controller,_action,_env              
      _excp = Exception.by_exception(exc.class).by_message(exc.message).by_controller(_controller).by_action(_action).by_environment(_env)
      if _excp.present?
        return _excp.first
      else
        _excp = Exception.new
        _excp.set_attributes_for exc, _controller, _action, _env
        _excp.save!
        _excp
      end
    end

    # Sets Exception instance attributes.
    def set_attributes_for exc, _controller, _action, _env
      self.exception = exc.class
      self.message = exc.message
      self.controller = _controller
      self.action = _action
      self.app_environment = _env
      self.status = "new"
    end

  end
end
