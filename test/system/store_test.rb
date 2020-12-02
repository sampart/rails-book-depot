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

  test "Most recently added item in cart is highlighted" do
    visit store_index_url
    assert_no_selector ".line-item-highlight"

    click_on "Add to cart", match: :first
    assert_selector ".line-item-highlight", count: 1

    # the second "Add to cart" button
    page.all('.price input[type=submit]')[2].click
    assert_selector ".line-item-highlight", count: 1

    # remove an item from the cart, so it'll reload
    # with no most recent item

    click_on "-", match: :first
    assert_no_selector ".line-item-highlight"
  end
end
