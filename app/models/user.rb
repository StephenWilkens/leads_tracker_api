class User < ApplicationRecord
  has_many :customers

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password
end
