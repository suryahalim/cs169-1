##################################
# Test user_id must be integer
# Test address must be string
# Test hours must be string
# Test no restaurant
# Test no picture
# Test no ratings
# Test waitlist button
# Test rating button
# Test Open now!
# Test Price level

require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  # test "should get new" do
  #   get :new
  #   assert_nil(Restaurant.id , "id is empty")
  #   assert_response :success
  # end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
        post :create, restaurant: { user_id: "10", address: "MLK", hours: "24hr" }
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show, id: @restaurant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @restaurant
    assert_response :success
  end

  test "should update restaurant" do
    patch :update, id: @restaurant, restaurant: { user_id: "10", address: "MLK", hours: "24hr" }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete :destroy, id: @restaurant
    end

    assert_redirected_to restaurants_path
  end
end
