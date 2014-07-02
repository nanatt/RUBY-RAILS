class Article < ActiveRecord::Base
	validates_presence_of :title, :body

	def long_title
		"#{title} - #{published_at}"
	end
end
