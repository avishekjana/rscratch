json.status @error.present? ? "error" : "ok"
json.message @error.present? ? @error.message : "Exception data loaded."
if @error.present?
  json.data Array.new
else
  json.data do
    json.extract! @excp, :action, :app_environment, :controller, :exception, :message, :new_occurance_count, :total_occurance_count
    json.log do
      json.extract! @log.first, :backtrace, :client_ip, :description, :exception_id, :parameters, :request_method, :request_url, :status, :user_agent
    end
    json.log_summary @historical_data
  end
end