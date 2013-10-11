class Deck < ActiveRecord::Base
  validates :category, presence: true

  has_many :cards
  has_many :rounds
end
