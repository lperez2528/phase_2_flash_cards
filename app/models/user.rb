class User < ActiveRecord::Base
  include BCrypt
  vilidates :name, presence: true
  validates :email, :format => { :with => /\w+@\w+\.\w{2,}/, :message => "invalid email" }, :uniqueness => true
  
  has_many :rounds

end
