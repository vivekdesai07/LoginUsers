class User < ActiveRecord::Base
  attr_accessor :password

  # Validating fields
  validates :username, :email, :password, presence: true
  validates :email, format: { with: /@/ }
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password, length: { in: 6..20 }

  # Encrypting process for new user's password
  before_save :encrypt_password
  after_save :clear_password

  private
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  private
  def clear_password
    self.password = nil
  end

end
