get '/' do
  erb :index
end

post '/login' do
  redirect to '/profile/user_name'
end

get '/signup' do
  erb :signup
end

post '/create' do
  redirect to '/profile/user_name'
end

get '/profile/user_name' do
  @name = "Paul"

  erb :profile
end

get '/logout' do

  erb :index
end
