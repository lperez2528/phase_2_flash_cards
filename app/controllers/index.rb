set :session_expired, 60*60

get '/' do
  if session?
    @user = User.find(session[:user_id])
    redirect to "/profile/#{@user.id}"
  end
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
  session_start!
  redirect to "/profile/#{@user.id}"
end

get '/profile/:user_id' do
  session[:user_id]
  session_start!
  @user = User.find(session[:user_id])
  @decks = Deck.all
  erb :profile
end

get '/logout' do
  session[:user_id] = nil
  session_end!
  erb :index
end

#Profile.erb, submit deck_id in a form
get '/play' do
  session[:user_id]
  @deck = Deck.find(params[:deck_id])
  @round = Round.create(user_id: session[:user_id], deck_id: @deck.id)
  @card_number = 1
  @current_card = Card.find(@card_number)
      p "This is my @user_answer: #{@current_card.answer}"
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

  while @card_number < @deck_length
    if @card_number > 1
      @previous_card = Card.find(@card_number - 1)
    end

    @user_answer = params[:user_answer] 

    if @user_answer == @current_card.answer
      @correctness = true
      @correct_guess_count += 1
      Round.update(@round.id, correct_guess_count: @correct_guess_count)

      @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
      correctness: @correctness
      )
      @card_number += 1
      redirect to "/play/#{@correctness}/#{@round.id}/#{@card_number}/"
    else
      @correct_guess_count += 1
      Round.update(@round.id, correct_guess_count: @correct_guess_count)

      @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
      )
      @card_number += 1
      redirect to "/play/#{@round.id}/#{@card_number}/"
    end
  end
  
  @user_answer = params[:user_answer] 

  if @user_answer == @current_card.answer
    @correctness = true
    @correct_guess_count += 1
    Round.update(@round.id, correct_guess_count: @correct_guess_count)
  
    @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
      correctness: @correctness
    )

    redirect to "/game_complete/#{@current_card.id}/#{@correctness}/#{@round.id}/"

  else
    @correct_guess_count += 1
    Round.update(@round.id, correct_guess_count: @correct_guess_count)
  
    @guess = Guess.create(
      answer_input: @user_answer, 
      card_id: @card_number, 
      round_id: @round.id, 
    )

    redirect to "/game_complete/#{@current_card.id}/#{@round.id}/"

  end
end

get '/play/:round_id/:card_number/' do
  @round = Round.find(params[:round_id])
  @card_number = (params[:card_number]).to_i
  @current_card = Card.find(@card_number)
  @previous_card = Card.find(@card_number - 1)
  @deck = Deck.find(@round.deck_id)
  @correctness = params[:correctness]

  p "This is my @correctness: #{@correctness}"
  @correct_guess_count = @round.correct_guess_count

  erb :play
end

get '/play/:correctness/:round_id/:card_number/' do
  @round = Round.find(params[:round_id])
  @card_number = (params[:card_number]).to_i
  @current_card = Card.find(@card_number)
  @previous_card = Card.find(@card_number - 1)
  @deck = Deck.find(@round.deck_id)
  @correctness = params[:correctness]

  p "This is my @correctness: #{@correctness}"
  @correct_guess_count = @round.correct_guess_count

  erb :play
end

get "/game_complete/:card_id/:correctness/:round_id/" do
  @current_card = Card.find(params[:card_id])
  erb :game_complete
end

get "/game_complete/:card_id/:round_id/" do
  @current_card = Card.find(params[:card_id])
  erb :game_complete
end

get '/results' do
  @user = User.find(session[:user_id])
  p @rounds = @user.rounds

  erb :results
end
