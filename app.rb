class FindBebe < Sinatra::Base
  set :method_override, true
  configure :development do
    register Sinatra::Reloader
  end

  require './pet'

  post '/' do
    pet = Pet.new(params['pet_name'],
                  params['pet_description'])
    pet.save
    redirect '/'
  end

  get '/' do
    erb :index, locals: {pets: Pet.all}
  end

  delete '/:id' do |id|
    Pet.delete(id.to_i)
    redirect '/'
    "Deleting pet listing!"
  end

  get '/:id/edit' do |id|
    pet = Pet.find(id.to_i)
    erb :edit, locals: {id: id, pet: pet}
  end

  put '/:id' do |id|
    data = {
      :name => params['pet_name'],
      :description => params['pet_description']
    }
    Pet.update(id.to_i, data)
    redirect '/'
  end

  not_found do
    erb :error
  end

end
