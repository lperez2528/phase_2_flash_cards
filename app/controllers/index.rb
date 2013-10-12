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
  @user = User.create(name: params[:name], email: params[:email], password: params[:password])
  session[:user_id] = @user.id
  redirect to "/profile/#{@user.id}"
end

get '/profile/:user_id' do
  session[:user_id]
  @user = User.find(session[:user_id])
  @decks = Deck.all
  erb :profile
end

get '/logout' do
  erb :index
end

get '/play/deck_id' do
  session[:user_id]
  @correctness = "correct" # Insert dynamic data
  params[:deck_id]
  
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
