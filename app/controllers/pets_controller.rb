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
    @pet = Pet.create(:name => params[:pet][:name])
    @owner = Owner.find_by(:id => params[:pet][:owner_id].first) unless params[:pet][:owner_id].nil?
    @owner ||= Owner.create(:name => params[:owner][:name]) unless params[:owner][:name].nil?
    if @owner
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
#    @pet = Pet.find(params[:id])
#    @pet.update(:name => params[:pet][:name])
#    if params[:owner][:name]
#      @owner = Owner.create(:name => params[:owner][:name]) 
#    else
#      @owner = Owner.find_by(:id => params[:pet][:owner_id].first)
#    end
#    @owner.pets << @pet
#    @pet.owner = @owner 
#    @owner.save
#    @pet.save
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name] != ""
      @pet.owner = Owner.create(:name => params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
end

