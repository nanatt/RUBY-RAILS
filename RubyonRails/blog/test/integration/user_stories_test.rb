require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should login create article and redirect" do
    #Login
  	get login_path

  	assert_response :success
  	assert_template 'new'

  	post session_path, :email => 'lauren@example.com', :password => 'secret'

  	assert_response :redirect
  	assert_redirected_to root_path

  	follow_redirect!

  	assert_response :success
  	assert_template 'index'
  	assert session[:user_id]
  #Create New Article
  get new_article_path

  assert_response :success
  assert_template 'new'

  post articles_path, :article => {title: 'Integration Tests', body: "Let's do this"}
  assert assigns(:article).valid?
  assert_response :redirect
  assert_redirected_to article_path(assigns(:article))

  follow_redirect!

  assert_response :success
  assert_template 'show'
  
  #Logout
    get logout_path
    assert_response :redirect
    assert_redirected_to root_path
    assert_nil session[:user]
    follow_redirect!
    assert_template 'index'
  end

end
