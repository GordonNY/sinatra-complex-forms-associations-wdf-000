class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(params[:pet])
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      owner.pets << @pet
      owner.save
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])

      @pet.owner_id = owner.id
      @pet.save

    end

    redirect to "pets/#{@pet.id}"
  end


end
