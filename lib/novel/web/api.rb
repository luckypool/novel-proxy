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

      namespace :authors do
        params do
          requires :id, type: String
        end
        get ':id' do
          id = params[:id]
          c = ::Novel::API::Client.new
          response = c.fetch_by_author_id(id)
          # error! "#{id} is not_found", 404
          response
        end
      end

      get :novels do
        limit = params[:limit] || 20
        c = ::Novel::API::Client.new
        c.fetch_updates(limit: limit)
      end

      namespace :novels do
        params do
          requires :id, type: String
        end
        get ':id' do
          id = params[:id]
          c = ::Novel::API::Client.new
          response = c.fetch_novel_detail(id)
          # error! "#{id} is not_found", 404
          response
        end
      end
    end
  end
end
