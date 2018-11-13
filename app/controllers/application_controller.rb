class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  helpers do
    def all_owners
      Owner.all
    end

    def newest_owner
      Owner.last
    end

    def current_owner
      Owner.find_by(params[:id])
    end

    def all_pets
      Pet.all
    end

    def newest_pet
      Pet.last
    end

    def current_pet
      Pet.find_by(params[:id])
    end
  end
end
