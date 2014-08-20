class Product < ActiveRecord::Base
	validates_presence_of :title, :description, :image_url
	validates_numericality_of :price, greater_than: 0

	validates_uniqueness_of :title
	validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png|jpeg)\Z}i, 
	message: 'must be a URL for GIF, JPG, PNG, JPEG image.'}

	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	def self.latest 
		Product.order(:updated_at).last
	end

	private
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end
end
