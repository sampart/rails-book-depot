require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    # You can only work with the cart in session, so put a cart in session
    # by visiting the right page.
    #
    # First destroy the fixture ones, though. This could be accomplished by
    # removing the fixtures file, but it's neater to explicitly set state here.
    Cart.destroy_all
    visit new_order_url
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "creating a Cart" do
    visit carts_url
    click_on "New Cart"

    click_on "Create Cart"

    assert_text "Cart was successfully created"
  end

  test "updating a Cart" do
    visit carts_url
    click_on "Edit", match: :first

    click_on "Update Cart"

    assert_text "Cart was successfully updated"
  end

  test "destroying a Cart" do
    visit carts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Your cart is currently empty"
  end
end
