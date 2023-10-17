class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  validates :email, presence: true, format: { with: Devise::email_regexp }
  validates :password, presence: true, length: { minimum: 1 }

  has_one :profile
end
