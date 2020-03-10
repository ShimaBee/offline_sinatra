require 'sinatra'
require 'sinatra/reloader'
require 'pg'

enable :sessions

db = PG::connect(
  :host => 'localhost',
  :password => '',
  :dbname => "offline_sinatra_app")

get '/' do
  @posts = db.exec('select * from posts order by id desc')
  erb :index
end

get '/signup' do
  erb :signup
end

post '/signup' do
  name = params[:name]
  password = params[:password]
  db.exec("insert into users (name, password) values($1, $2)",[name, password])
  redirect '/login'
end

get '/login' do
  erb :login
end

post '/login' do
  name = params[:name]
  password = params[:password]
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
  image =  params[:image][:filename]
  FileUtils.mv(params[:image][:tempfile], "./public/images/#{params[:image][:filename]}")
  db.exec("insert into posts (title, contents, image) values($1, $2, $3)",[title, contents,image])
  redirect '/'
end