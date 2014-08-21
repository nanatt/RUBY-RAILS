require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
  # test "the truth" do
  #   assert true
  # end
=begin
HISTORY:

  A user goes to the index page. They select a product, adding it to their
  cart, and check out, filling in their details on the checkout form. When
  they submit, an order is created containing their information, along with a
  single line item corresponding to the product they added to their cart.
=end
  test "buying a product" do
  	LineItem.delete_all
  	Order.deleta_all
  	ruby_book = products(:ruby)

  	#A user goes to the store index page.
  	get "/"
  	assert_response :success
  	assert_template "index"

  	#They select a product, adding it to their cart. 
  	#The application uses ajax so to test i'll need 'xml_http_request()'
  	xml_http_request :post, '/line_items', product_id: ruby_book.id
  	assert_response :success

  	cart = Cart.find(session[:cart_id])
  	assert_equal 1, cart.line_items.size
  	assert_equal ruby_book, cart.line_items[0].product

  	#they then check out
  	get "/orders/new"
  	assert_response :success
  	assert_template "new"

  	#At this point, the user has to fill in their details on the checkout form. 
  	#Once they do and they post the data, our application creates the order and redirects to the index page.
  	post_via_redirect "/orders", #generates the post request and then follows any redirects returned until a nonredirect response is returned.
  	order: {
  		name: "Dave Thomas",
  		address: "123 The street",
  		email: "dave@example.com",
  		pay_type: "Check"}
  	assert_response :success
  	assert_template "index"
  	cart = Cart.find(session[:cart_id])
  	assert_equal 0, cart.line_items.size

  	#wander into the database and make sure we’ve created an order and 
  	#corresponding line item and that the details they contain are correct.
  	orders = Order.all
  	assert_equal 1, orders.size
  	order = orders[0]

  	assert_equal "Dave Thomas", order.name
  	assert_equal "123 The Street", order.address
  	assert_equal "dave@example.com", order.email
  	assert_equal "Check", order.pay_type

  	assert_equal 1, order.line_items.size
  	line_item = order.line_items[0]
  	assert_equal ruby_book, line_item.product

  	#Verifying that the mail itself is correctly addressed and has the expected subject line
  	mail = ActionMailer::Base.deliveries.last
  	assert_equal ["dave@example.com"], mail.to
  	assert_equal 'depot@example.com', mail[:from].value
  	assert_equal "Pragmatic Store Order Confirmation", mail.subject
	end
end
