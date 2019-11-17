require 'sinatra'
require 'sinatra/reloader'
require 'pg'

enable :sessions

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

post '/login' do
  name = params[:name]
  password = params[:password]
  # binding.irb
  id = db.exec("select id from users where name = $1 and password = $2",[name, password]).first
  if id
    session[:user_id] = id['id']
    redirect '/'
  else
    redirect '/login'
  end
end

post '/post' do
  title = params[:title]
  contents = params[:contents]
  db.exec("insert into posts (title, contents) values($1, $2)",[title, contents])
  redirect '/'
end