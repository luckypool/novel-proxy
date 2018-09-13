# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'grape'
gem 'sinatra'
gem 'hashie'
gem 'faraday'
gem 'faraday_middleware'

group :test do
  gem 'rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'webmock'
end

group :develop do
  gem 'pry-byebug'
end
