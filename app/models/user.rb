class User < ApplicationRecord
        extend Devise::Models

        # Include default devise modules.
        devise :database_authenticatable, :registerable,
               :recoverable, :rememberable, :validatable,
               :confirmable, :trackable, :omniauthable
      
        include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> {new_record? || !password.nil? }

  #hashes passwords using bcrypt
  has_secure_password
end
