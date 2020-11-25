require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carts_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_url
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {  } }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test "should show cart" do
    get cart_url(new_cart_in_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_url(new_cart_in_session)
    assert_response :success
  end

  test "should update cart" do
    cart = new_cart_in_session
    patch cart_url(cart), params: { cart: {  } }
    assert_redirected_to cart_url(cart)
  end

  test "should destroy cart" do
    post line_items_url, params: { product_id: products(:ruby).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end

  private

  def new_cart_in_session
    get new_order_url # will set a new cart in session
    Cart.find(session[:cart_id])
  end
end
