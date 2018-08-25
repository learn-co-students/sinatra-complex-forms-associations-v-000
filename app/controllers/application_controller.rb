class ApplicationController < Sinatra::Base
  # get '/' do
  #   "Hello World"
  # end
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
end
