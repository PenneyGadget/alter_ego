class User < ActiveRecord::Base
  belongs_to :team
  has_secure_password

  enum role: %w(default admin)
end
