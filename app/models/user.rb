class User < ActiveRecord::Base
  validates :username, :email, :encrypted_password, :salt, presence: true
end
