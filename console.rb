def reload!
  load "./config/environment.rb"  
end

require_relative "./config/environment"

Pry.start