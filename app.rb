require 'sinatra/base'
require 'grape'

class API < Grape::API
  content_type :json, 'application/json'
  default_format :json

  get :hello do
    { hello: 'world' }
  end
end

class Web < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
