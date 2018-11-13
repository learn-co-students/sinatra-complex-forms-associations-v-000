class OwnersController < ApplicationController

  get '/owners' do
    erb :'/owners/index'
  end

  get '/owners/new' do
    erb :'/owners/new'
  end

  post '/owners' do
    Owner.create(params[:owner])
    newest_owner.pets << Pet.create(name: params[:pet][:name]) unless params[:pet][:name].empty?
    redirect "owners/#{newest_owner.id}"
  end

  get '/owners/:id/edit' do
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    current_owner.update(params[:owner])
    current_owner.pets << Pet.create(name: params[:pet][:name]) unless params[:pet][:name].empty?
    redirect "owners/#{current_owner.id}"
  end
end
