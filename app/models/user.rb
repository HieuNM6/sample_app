class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
	validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-zA-Z]+/
	validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: {cass_sensitive: false}
  has_secure_password
  validates :password, length: { minimum: 6}
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                            BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
