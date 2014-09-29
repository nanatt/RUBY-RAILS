class User < ActiveRecord::Base
	validates_presence_of :name, length: { maximum: 50 }

	before_save { self.email = email.downcase }
	validates_presence_of :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, uniqueness: true

	has_secure_password
end
