class User < ApplicationRecord

  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password can\'t be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  def self.generate_session_token
     SecureRandom::urlsafe_base64(16)
  end



  private
    def ensure_session_token
    # we must be sure to use the ||= operator instead of = or ||, otherwise
    # we will end up with a new session token every time we create
    # a new instance of the User class. This includes finding it in the DB!
    self.session_token ||= self.class.generate_session_token
  end

end
