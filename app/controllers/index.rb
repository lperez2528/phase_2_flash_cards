get '/' do
  # Look in app/views/index.erb
  erb :index
end


post '/login' do

  redirect to '/profile/:user_id'
end


get '/profile/:user_id' do

  erb :profile
end

get '/signup' do

  erb :signup
end

post '/create' do
  
  
end
