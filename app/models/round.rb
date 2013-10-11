class Round < ActiveRecord::Base
  validates :correct_guess_count, presence: true 
  validates :incorrect_guess_count, presence: true 

  belongs_to :user
  belongs_to :deck
  has_many :guesses
end
