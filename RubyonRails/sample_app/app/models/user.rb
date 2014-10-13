class User < ActiveRecord::Base
	validates_presence_of :name, length: { maximum: 50 }

	before_save { self.email = email.downcase }
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, 
	uniqueness: { case_sensitive: false }

	validates :password, presence: true, length: { minimum: 6 }

	has_secure_password
end
