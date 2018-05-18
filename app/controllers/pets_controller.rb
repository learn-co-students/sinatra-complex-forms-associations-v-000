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
    # puts "Params = #{params}"
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params[:owner_name])
    elsif !params["owner"].empty?
      @owner = Owner.find(params["owner"][0])
    end
    @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    # puts "Pet = #{@pet.name} owner = #{@pet.owner_id}|| Owner = #{@owner.name} || Owner id = #{@owner.id}"

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end
end
