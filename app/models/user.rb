class User < ActiveRecord::Base
  belongs_to :team
  has_secure_password
  validates :username, presence: true, uniqueness: true
  # validates_presence_of :name, :team_id, :tagline, :gif_link, :password, :password_confirmation

  enum role: %w(default admin)
end
