class User < ApplicationRecord
       extend Devise::Models
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable

       include DeviseTokenAuth::Concerns::User

       # validates :email, presence: true, uniqueness: true
       # validates :password, presence: true, length: { minimum: 6 }, if: -> {new_record? || !password.nil? }
end
