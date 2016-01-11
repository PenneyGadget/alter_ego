class Team < ActiveRecord::Base
  has_many :users
  has_many :auctions
  has_secure_password
  validates :name, presence: true, uniqueness: true

end
