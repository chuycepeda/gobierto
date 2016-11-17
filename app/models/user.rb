class User < ApplicationRecord
  include Authentication::Authenticable
  include Authentication::Confirmable
  include Authentication::Recoverable
  include Session::Trackable

  EMAIL_ADDRESS_REGEXP = /\A(.+)@(.+\..+)\z/

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: { with: EMAIL_ADDRESS_REGEXP }
end