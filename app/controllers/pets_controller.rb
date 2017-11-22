class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet=Pet.create(name: params[:pet]["name"])


        if params.include?("owner_id")
          @pet.owner = Owner.find(params["owner_id"])
          @pet.save
        else

          @pet.owner = Owner.new(name: params["owner_name"])
          @pet.save
        end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
  get '/pets/:id/edit' do

      @pet = Pet.find(params[:id])
      @owner = @pet.owner
      erb :'/pets/edit'
    end

    post '/pets/:id/edit' do

      @pet=Pet.find(params[:id])
      @pet.update(name: params[:pet]["name"])

      @pet.owner = Owner.find(params[:owner_id])
      @pet.save
      if params[:owner]["name"] != ""
        @pet.owner = Owner.new(name: params[:owner]["name"])
        @pet.save
      end


      redirect to  "pets/#{@pet.id}"
    end

end
