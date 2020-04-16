class User < ApplicationRecord
  after_initialize :ensure_session_toquen

  attr_reader :password

  validates :username, presence: true
  validates :password_digest, length: { minimum: 6, allow_nil: true }
  validates :password, presence: true


  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && BCrypt::Password.new(self.password_digest).is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCypt::Passord.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_toquen
    self.session_token ||= self.class.generate_session_token
  end
end
