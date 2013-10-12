get '/' do
  erb :index
end

post '/' do
  @user = User.find_by_email(params[:email])
  session[:user_id] = @user.id
  redirect to "/profile/#{@user.id}"
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


#Profile.erb, submit deck_id in a form
get '/play' do
  session[:user_id]
  @deck = Deck.find(params[:deck_id])
  @round = Round.create(user_id: session[:user_id], deck_id: @deck.id)
  @card_number = 1  
  erb :play
end


#Play.erb, question form
post '/play/:round_id/:card_id' do
  session[:user_id] 
  @round = Round.find(params[:round_id])
  @deck = Deck.find(@round.deck_id)
  @card_number = (params[:card_id]).to_i
  @current_card = Card.find(@card_number)
  @user = session[:user_id]

  if @round
    @card_number += 1
    # assess correctness
    @user_answer = params[:user_answer] 

    if @user_answer == @current_card.answer
      @correctness = true
    else
      @correctness = false
    end
    @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
      correctness: @correctness
      )
  end

  erb :play
end


get '/results' do
  # @name = "Paul"
  erb :results
end
