class User < ActiveRecord::Base
	validates :username, uniqueness: true, presence: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
