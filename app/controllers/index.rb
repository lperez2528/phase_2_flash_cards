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
  session[:user_id] = nil
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
  @deck_length = @deck.cards.length
  @correct_guess_count = @round.correct_guess_count
  p "This is the card number: #{@card_number} !!!!!!!!!!!!!!!!!!!"


  while @card_number < @deck_length
    @card_number += 1
    p "This is the card number: #{@card_number} !!!!!!!!!!!!!!!!!!!"
    # assess correctness
    @user_answer = params[:user_answer] 

    if @user_answer == @current_card.answer
      @correctness = true
      @correct_guess_count += 1
      Round.(id: @round.id, correct_guess_count: @correct_guess_count)
    else
      @correctness = false
    end

    @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
      correctness: @correctness
      )
    redirect to "/play/#{@round.id}/#{@card_number}/"
  end
  
  if @user_answer == @current_card.answer
    @correctness = true
    @correct_guess_count += 1
    @round.update(correct_guess_count: @correct_guess_count)
  else
    @correctness = false
  end
  
  @guess = Guess.create(
    answer_input: @user_answer, 
    card_id: @card_number, 
    round_id: @round.id, 
    correctness: @correctness
    )

  redirect to "/game_complete/#{@current_card.id}/#{@correctness}/#{@round.id}/"
end

get '/play/:round_id/:card_number/' do
  @round = Round.find(params[:round_id])
  @card_number = params[:card_number]
  @current_card = Card.find(@card_number)
  @deck = Deck.find(@round.deck_id)
  @correct_guess_count = @round.correct_guess_count


  erb :play
end

get "/game_complete/:card_id/:correctness/:round_id/" do

  erb :game_complete
end


get '/results' do
  # @name = "Paul"
  erb :results
end
