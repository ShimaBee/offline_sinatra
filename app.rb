require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end