require 'test_helper'


class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    # @restaurant = Restaurant.new(user_id: 1, address: '1893 Berkeley Avenue', hours: '9:00 am - 10:00 pm')
    # @restaurant.save
    # @user = User.new(id: 1, name: 'rest 1', email: 'FendyOnel@gmail.com', rest: true, password: '123123123', password_confirmation: '123123123')
    # @user.save
    request.env["devise.mapping"] = Devise.mappings[:user]
    @customer = Customer.new(user_id:2, phone_number: 0000)
    @customer.save
    @user = User.new(id: 2, name: 'user 1', email: 'AtidJenad@gmail.com', rest: false, password: '123123123', password_confirmation: '123123123')
    @user.save
  end

  test "sign up user successfully" do
    sign_in @user
    assert_true(Devise.user_signed_in?)
    # post :create_user, {name: 'user 2', email: 'customer@gmail.com', password: '123123123', password_confirmation: '123123123'}
    # post create_user_path, name: 'user 2', email: 'customer@gmail.com', password: '123123123', password_confirmation: '123123123'
    assert_response :success

  end
  # test "sign up failed" do
  # end
  # test "log in successfully" do
  # end
  # test "log in fail " do
  # end

  # test "should create restaurant" do
  #   assert_difference('Restaurant.count') do
  #       post :create, restaurant: { user_id: "10", address: "MLK", hours: "24hr" }
  #   end
  #   assert_redirected_to restaurant_path(assigns(:restaurant))
  # end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:restaurants)
  # end
end
