json.status @error.present? ? "error" : "ok"
json.message @error.present? ? @error.message : "Exception data updated."
if @error.present?
  json.data Hash.new
else
  json.data @excp
end