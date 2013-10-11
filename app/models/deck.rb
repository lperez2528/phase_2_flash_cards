class Deck < ActiveRecord::Base
  # Remember to create a migration!
  validates :category, presence: true

  has_many :cards
  has_many :rounds
end
