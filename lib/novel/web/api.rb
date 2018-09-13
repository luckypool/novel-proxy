require 'sinatra/base'
require 'grape'
require 'novel'

module Novel
  module Web
    class API < Grape::API
      content_type :json, 'application/json'
      default_format :json

      get :hello do
        { hello: 'world' }
      end

      namespace :novel do
        get :updates do
          limit = params[:limit] || 20
          c = ::Novel::API::Client.new
          c.fetch_updates(limit: limit)
        end
      end
    end
  end
end
