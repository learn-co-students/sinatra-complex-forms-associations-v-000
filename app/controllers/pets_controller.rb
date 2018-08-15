class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if (@pet = Pet.create(params[:pet]))
      @pet.update(owner: @owner) if (@pet.owner.nil? && (@owner = Owner.create(params[:owner])))
      redirect to "pets/#{@pet.id}"
    else
      erb :'/pets/index'
    end
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    if @pet = Pet.find_by(id: params[:id])
      @owners = Owner.all
      erb :'pets/edit'
    else
      redirect '/pets'
    end
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.update(owner: @owner) if ((@owner = Owner.new(params[:owner])) && @owner.save)
    redirect "/pets/#{@pet.id}"
  end
end