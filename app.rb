class FindBebe < Sinatra::Base
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

  not_found do
    erb :error
  end

end
