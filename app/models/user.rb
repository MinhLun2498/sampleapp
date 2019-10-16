class User < ApplicationRecord
  before_save{ email.downcase! }
  VALID_EMAIL_REGEX = Settings.validemailregex.freeze

  validates :name, presence: true, length: {maximum: Settings.max50}
  validates :email, presence: true, length: {maximum: Settings.max255},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length: {minimum: Settings.min6}

  has_secure_password

  class << self
    def digest string
      if ActiveModel::SecurePassword.min_cost
        cost = BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
