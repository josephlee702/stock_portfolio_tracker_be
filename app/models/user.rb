class User < ApplicationRecord
  has_many :portfolios, dependent: :destroy

  #bcrypt user auth
  has_secure_password
end
