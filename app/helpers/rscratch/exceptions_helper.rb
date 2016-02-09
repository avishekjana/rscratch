module Rscratch
  module ExceptionsHelper
    def get_issue_color(object)
      if object.resolved?
        return "green"
      elsif object.ignored?
        return "grey"
      else
        return "red"
      end 
    end
  end
end
