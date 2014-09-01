class User < ActiveRecord::Base
	validates_presence_of :name, :email, uniqueness: true
  	has_secure_password
  	after_destroy :ensure_an_admin_remains

  	private
  	def ensure_an_admin_remains
  		if User.count.zero?
  			raise "Can't delete last user"
  		end
  	end
end
