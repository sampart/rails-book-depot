require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.new
  end

  test "add unique products to cart" do
    @cart.add_product(products(:ruby)).save!
    @cart.add_product(products(:one)).save!

    assert_equal 2, @cart.line_items.size
  end

  test "add duplicate products to cart" do
    @cart.add_product(products(:ruby)).save!
    @cart.add_product(products(:ruby)).save!
    @cart.add_product(products(:one)).save!

    assert_equal 2, @cart.line_items.size
    assert_equal 2, @cart.line_items.first.quantity
    assert_equal 1, @cart.line_items.second.quantity
  end
end
