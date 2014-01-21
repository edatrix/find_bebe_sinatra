require 'bundler'
require 'find_bebe'

class FindBebeApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  post '/' do
    PetStore.create(params[:pet])
    redirect '/'
  end

  get '/' do
    erb :index, locals: {pets: PetStore.all, pet: Pet.new}
  end

  delete '/:id' do |id|
    PetStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    pet = PetStore.find(id.to_i)
    erb :edit, locals: {id: id, pet: pet}
  end

  put '/:id' do |id|
    PetStore.update(id.to_i, params[:pet])
    redirect '/'
  end

  not_found do
    erb :error
  end

end
