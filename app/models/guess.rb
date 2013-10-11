class Guess < ActiveRecord::Base
  validates :answer_input, presence: true
  
  belongs_to :round
  belongs_to :card
end
