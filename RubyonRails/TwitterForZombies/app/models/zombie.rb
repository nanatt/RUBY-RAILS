class Zombie < ActiveRecord::Base
	has_many :assignments
	has_many :roles, through: :assignments

	has_one :brain, dependent: :destroy
	scope :rotting, where(rotting: true)
	scope :fresh, where("age < 20")
	scope :recent, order("created_at desc").limit(3)

	before_save :make_rotting
	def make_rotting
		if age && age > 20
			self.rotting = true
		end
	end

	after_save :decomp_change_notification, if: :decomp_changed?

	private
	
	def decomp_change_notification
		ZombieMailer.decomp_change(self).deliver
	end

	def as_json(options = nil)
		super(options || {
			include: :brain, except: [:created_at, :updated_at, :id]})
	end
end
