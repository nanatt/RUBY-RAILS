class Product < ActiveRecord::Base
	validates_presence_of :title, :description, :image_url
	validates_numericality_of :price, greater_than: 0

	validates_uniqueness_of :title
	validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png|jpeg)\Z}i, 
	message: 'must be a URL for GIF, JPG, PNG, JPEG image.'}
end
