class User < ApplicationRecord
  has_many :portfolios, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> {new_record? || !password.nil? }

  #hashes passwords using bcrypt
  has_secure_password
end
