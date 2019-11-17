require 'sinatra'
require 'sinatra/reloader'
require 'pg'

db = PG::connect(:dbname => "offline_sinatra_app")

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/signup' do
  name = params[:name]
  password = params[:password]
  # binding.irb
  db.exec("insert into users (name, password) values($1, $2)",[name, password])
  redirect '/login'
end

get '/login' do
  erb :login
end

post '/post' do
  title = params[:title]
  contents = params[:contents]
  db.exec("insert into posts (title, contents) values($1, $2)",[title, contents])
  redirect '/'
end