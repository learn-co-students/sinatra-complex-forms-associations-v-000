class OwnersController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    erb :'/owners/new'
  end

  post '/owners' do
    # binding.pry
    @owner = Owner.create(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params['id'])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params['id'])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    @owner = Owner.find(params['id'])
    ####### bug fix
    if !params["owner"].keys.include?("pet_ids")
    params["owner"]["pet_ids"] = []
    end
    #######

    @owner.update(params["owner"])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
  end
end
