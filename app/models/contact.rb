class Contact < ActiveRecord::Base
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :mobile, length: {is: 10}
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
