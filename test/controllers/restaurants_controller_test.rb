##################################################################################
# Test user_id must be integer -- done
# Test address must be string -- done
# Test hours must be string -- done
# Test no restaurant -- done
# Test no picture -- not sure if necessary?
# Test no ratings -- not yet implemented
# Test waitlist button -- unit test see restaurant_test.rb
# Test rating button -- not yet implemented
# Test Open now! -- not yet implemented
# Test Price level -- may be too difficult? Sol: all price in integer

require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = Restaurant.new(user_id: 1, address: '1893 Berkeley Avenue', hours: '9:00 am - 10:00 pm')
    @restaurant.save
    @user = User.new(id: 1, name: 'rest 1', email: 'FendyOnel@gmail.com', rest: true, password: '123123123', password_confirmation: '123123123')
    @user.save
    
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  # test "should get new" do
  #   post :create, user: { email: "abc@gmail.com", encrypted_password: "abcd", reset_password_token: "abcd", reset_password_sent_at: "2015-10-09", remember_created_at: "2015-10-09", current_sign_in_at: "2015-10-10", last_sign_in_at: "2015-10-10", current_sign_in_ip: "192.168.1.5", last_sign_in_ip: "192.168.1.9", name: "FendyOnel", rest: true }
  #   get :new
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
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
    patch :update, id: @restaurant, restaurant: { user_id: "5", address: "MLK1", hours: "25hr" }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete :destroy, id: @restaurant
    end

    assert_redirected_to restaurants_path
  end

  # test "user_id is integer" do
  #   # print(@restaurant.user_id)
  #   # print(@customer.phone_number)
  #   # print(Restaurant.address)
  #   # print(Time.now.strftime("%I:%M%p"))
  #   assert_not_same("1", @restaurant.user_id, "user_id must be integer")
  # end

  # test "address is string" do
  #   assert_not_same(1893, @restaurant.address, "address must be string")
  # end

  # test "hours is string" do
  #   assert_not_same(9, @restaurant.hours, "hours must be string")
  # end


  # test "no restaurant count" do
  #   # Restaurant.new(user_id: 1, address: "1893 Berkeley Avenue", hours: "9:00 am - 10:00 pm") # create @restaurant instance
  #   # assert_not_nil assigns(:restaurant) # makes sure that a @restaurant instance variable was set
  #   # assert_difference(@restaurant.count, 1, "wrong")
  #   # assert_empty(0, 'Restaurant.count', "no restaurant found")
  #   @count = Restaurant.count
  #   assert_not_nil(@count, "No Restaurant found")
  # end
end



























