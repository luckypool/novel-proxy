require 'sinatra/base'
require 'grape'
require './novel/category'

class API < Grape::API
  content_type :json, 'application/json'
  default_format :json

  get :hello do
    { hello: 'world' }
  end

  get :small_categories do
    Novel::Category.small_categories
  end

  namespace :small_categories do
    params do
      requires :id, type: Integer
    end
    get ':id' do
      id = params[:id].to_i
      Novel::Category.find_small_category(id)
    end
  end

  get :large_categories do
    Novel::Category.large_categories
  end

  namespace :large_categories do
    params do
      requires :id, type: Integer
    end
    get '/:id' do
      id = params[:id].to_i
      Novel::Category.find_large_category(id)
    end
  end
end

class Web < Sinatra::Base
  get '/' do
    'alive!'
  end
end
