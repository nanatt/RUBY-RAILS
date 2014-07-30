require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "creating an article" do
    lauren = registered_user
    lauren.logs_in 'lauren@example.com', 'secret'
    lauren.creates_article title: 'Integration tests', body: "Lets do thissss"
    lauren.logs_out
  end
  
  private
  def registered_user
    open_session do |user|
      def user.logs_in(email, password)
        get login_path
        assert_response :success
        assert_template 'new'
        post session_path, :email => email, :password => password
        assert_response :redirect
        assert_redirected_to root_path
        follow_redirect!
        assert_response :success
        assert_template 'index'
        assert session[:user_id]
      end
      def user.logs_out
        get logout_path
        assert_response :redirect
        assert_redirected_to root_path
        assert_nil session[:user]
        follow_redirect!
        assert_template 'index'
      end
      def user.creates_article(article_hash)
        get new_article_path
        assert_response :success
        assert_template 'new'
        post articles_path, :article => article_hash
        assert assigns(:article).valid?
        assert_response :redirect
        assert_redirected_to article_path(assigns(:article))
        follow_redirect!
        assert_response :success
        assert_template 'show'
      end
    end
  end
end
