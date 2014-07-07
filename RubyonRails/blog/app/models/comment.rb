class Comment < ActiveRecord::Base
	belongs_to :article

	validates_presence_of :name, :email, :body
=begin
	#This checks whether you should apply the error by evaluating the if statement. 
	#f that if statement is true, you want to add an error into the errors object. 
	#Note that before you test whether the article is published, you make sure article isn’t nil. 
	#This is so your test doesn’t throw an error. 
	#If article is nil, that should be handled by another validator: the validates_presence_of method.
=end
	validate :article_should_be_published
	after_create :email_article_author

	def article_should_be_published
    	errors.add(:article_id, "is not published yet") if article && !article.published?
  	end

  	def email_article_author
    	puts "We will notify #{article.user.email} in Chapter 9"
	end
end
