require 'sinatra'
require 'faraday'
require 'faraday_middleware'
require 'json'

get '/' do
  connection = Faraday.new(:url => 'http://api.ihackernews.com') do |build|
    build.request  :json             
    build.response :json              
    build.adapter  Faraday.default_adapter
    build.use FaradayMiddleware::Mashify
  end

  response = connection.get '/page'

  @articles = Hashie::Mash.new(response.body).items

  erb :index
end