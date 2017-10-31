class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  helpers do
    def new_pet?(params)
      params["pet"]["name"].empty?
    end
  end
end
