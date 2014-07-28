require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:welcome_to_rails)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    login_as(:lauren)
    get :new
    assert_response :success
  end

  test "should create article" do
    login_as(:lauren)
    assert_difference('Article.count') do
      post :create, article: { body: @article.body, excerpt: @article.excerpt, location: @article.location, published_at: @article.published_at, title: @article.title }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show, :id => @article.to_param
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:article)
    assert assigns(:article).valid?
  end

  test "should get edit" do
    login_as(:lauren)
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    login_as(:lauren)
    patch :update, id: @article, article: { body: @article.body, excerpt: @article.excerpt, location: @article.location, published_at: @article.published_at, title: @article.title }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    login_as(:lauren)
    assert_nothing_raised {Article.find(@article.to_param)}

    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
    assert_raise(ActiveRecord::RecordNotFound) {Article.find(@article.to_param)}
  end
end
