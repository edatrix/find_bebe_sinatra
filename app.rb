require 'bundler'
Bundler.require

class FindBebe < Sinatra::Base

  get '/' do
    "what's up"
  end

end
