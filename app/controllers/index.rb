get '/' do
  erb :index
end

post '/login' do
  redirect to '/profile'
end

get '/signup' do
  erb :signup
end

post '/create' do
  redirect to '/profile'
end

get '/profile' do
  @name = "Paul"
  erb :profile
end

get '/logout' do
  erb :index
end

get '/play' do
  @correctness = "correct" # Insert dynamic data 
  erb :play
end

post '/play' do
  @correctness = "incorrect" # Insert dynamic data
  erb :play
end

get '/results' do
  # @name = "Paul"
  erb :results
end
