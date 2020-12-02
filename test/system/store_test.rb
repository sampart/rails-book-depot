require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "Cart appears when an item is added" do
    visit store_index_url

    assert_no_selector "h2", text: "Your Cart"

    click_on "Add to cart", match: :first

    assert_selector "h2", text: "Your Cart"
  end

  test "Cart disappears when it's emptied" do
    visit store_index_url

    click_on "Add to cart", match: :first
    assert_selector "h2", text: "Your Cart"

    page.accept_confirm do
      click_on "Empty cart"
    end
    
    assert_no_selector "h2", text: "Your Cart"
  end
end
