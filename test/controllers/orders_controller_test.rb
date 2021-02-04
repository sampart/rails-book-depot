require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end
  
  test "requires item in cart" do
    get new_order_url
    assert_redirected_to store_index_path
    assert_equal "Your cart is empty", flash[:notice]
  end

  test "should get new" do
    post line_items_url, params: { product_id: products(:ruby).id }

    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: pay_types(:credit_card).description } }
    end

    assert_redirected_to store_index_url(locale: 'en')
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type_id: @order.pay_type.id } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end

  test "should send notification when order shipped" do
    order = Order.all[0]
    assert_nil order.ship_date

    perform_enqueued_jobs do
      post order_ship_it_url(order)
    end

    order.reload
    refute_nil order.ship_date

    mail = ActionMailer::Base.deliveries.last
    refute_nil mail
    assert_equal [order.email], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Shipped", mail.subject
  end
end
