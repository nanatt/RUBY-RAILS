class CommentsController < ApplicationController
	before_filter :load_article, :except => :destroy
	before_filter :authenticate

	def create
		@comment = @article.comments.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.html {redirect_to @article, notice: 'Thanks for your comment'}
				format.js
			else
				format.html{redirect_to @article, alert: "Unable to add comment"}
				format.js {render 'fail_create.js.erb'}
			end
		end
	end

	def destroy
		#@article = current_user.articles.find(params[:article_id])
		@comment = current_user.replies.find(params[:id])
		respond_to do |format|
			if @comment.destroy
				format.html {redirect_to @article, notice: 'Comment Deleted'}
				format.js
			else
				format.html
				format.json
			end
		end
	end

	private
	def load_article
		@article = Article.find(params[:article_id])
	end

	def comment_params
		params.require(:comment).permit(:name, :email, :body)
	end
end
