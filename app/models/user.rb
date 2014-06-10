class User < ActiveRecord::Base
  attr_accessor :password

  # Validating fields
  validates :username, :email, :password, presence: true
  validates :email, format: { with: /@/ }
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password, length: { in: 6..20 }

  # Encrypting calls for new user's password
  before_save :encrypt_password
  after_save :clear_password

  # Authentication process for user's login
  def match_password(login_password = '')
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def self.authenticate(email_as_login = '', login_password = '')
    user = User.find_by_email(email_as_login)
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  # Encrypting process for new user's password
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
