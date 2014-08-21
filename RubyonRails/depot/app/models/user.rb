class User < ActiveRecord::Base
	validates_presence_of :name, :email, uniqueness: true
  	has_secure_password
end
