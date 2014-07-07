# Digest library you use for encrypting the passwords. 
require 'digest'
class User < ActiveRecord::Base
	#The password column doesn’t exist in your table anymore, a password method isn’t created automatically by Active Record.
	#Still, you need a way to set the password before it’s encrypted, so you make your own attribute to use.
	attr_accessor :password

	validates_uniqueness_of :email
	validates_length_of :email, :within => 5..50
	validates_format_of :email, :with =>  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	validates_confirmation_of :password
	validates_length_of :password, :within => 4..20
	validates_presence_of :password, :if => :password_required?

	has_one :profile, :dependent => :destroy
	has_many :articles, -> { order('published_at DESC, title ASC')}, :dependent => :destroy
	has_many :replies, :through => :articles, :source => :comments

	before_save :encrypt_new_password

	def self.authenticate(email, password)
    	user = find_by_email(email)
    	return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
    	self.hashed_password == encrypt(password)
	end

	protected
		def encrypt_new_password
			return if password.blank?
			self.hashed_password = encrypt(password)
		end

		def password_required?
			hashed_password.blank? || password.present?
		end

		def encrypt(string)
			Digest::SHA1.hexdigest(string)
		end
	#The SHA1 hashing algorithm used in this example is weak and was only used for an example.
		#https://github.com/codahale/bcrypt-ruby
end
