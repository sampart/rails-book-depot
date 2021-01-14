require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "must be logged in to see index" do
    logout
    get users_url
    assert_redirected_to login_url
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: 'sam', password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to users_url
  end

  test "can't create user if logged out" do
    logout
    assert_no_difference('User.count') do
      post users_url, params: { user: { name: 'sam', password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to login_url
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "update requires original password" do
    patch user_url(@user), params: { user: { name: @user.name, password: 'secret2', password_confirmation: 'secret2', original_password: 'wrong' } }
    assert_response :success
    assert_match 'must match existing password', @response.body
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: { name: @user.name, password: 'secret2', password_confirmation: 'secret2', original_password: 'secret' }
    }
    assert_redirected_to users_url
    follow_redirect!
    assert_match 'successfully updated', @response.body
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
