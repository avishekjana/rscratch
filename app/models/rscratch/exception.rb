module Rscratch
  class Exception < ActiveRecord::Base
    attr_accessible :action, :app_environment, :controller, :exception, :message, :new_occurance_count, :total_occurance_count
    ### => Model Relations
    has_many :exception_logs, :dependent => :destroy

    ### => Model Validations
    validates :exception       , presence: true
    validates :message         , presence: true
    validates :controller      , presence: true
    validates :action          , presence: true
    validates :app_environment , presence: true
                      
    ### => Model Scopes
    scope :by_exception, lambda {|exc|where(["exception=?", exc])}                      
    scope :by_message, lambda {|msg|where(["message=?", msg])}                      
    scope :by_controller, lambda {|con|where(["controller=?", con])}                      
    scope :by_action, lambda {|act|where(["action=?", act])}                      
    scope :by_environment, lambda {|env|where(["app_environment=?", env])}        

    def self.find_or_add_exception exc,_controller,_action,_env              
      _excp = Exception.by_exception(exc.class).by_message(exc.message).by_controller(_controller).by_action(_action).by_environment(_env)
      if _excp.present?
        return _excp.first
      else
        _new_excp = Exception.create( :exception        => exc.class,
                                      :message          => exc.message,
                                      :controller       => _controller,
                                      :action           => _action,
                                      :app_environment  => _env)
        return _new_excp
      end
    end
  end
end
