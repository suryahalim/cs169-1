require 'test_helper'
 
class RestaurantIntegrationTest < ActionDispatch::IntegrationTest
  setup do
   @restaurant = Restaurant.new(user_id: 3, address: '1892 Berkeley Avenue', hours: '9:00 am - 10:00 pm')
   @restaurant.save
   @user = User.new(id: 3, name: 'FendyOnel', email: 'FendyOnel@gmail.com', rest: true, password: '123123123', password_confirmation: '123123123')
   @user.save
 end

  test "login waitlist restaurant already sign up" do
    https?
    get "/restaurants"
    assert_response :success

    post_via_redirect create_user_path, 'user[name]' => 'FendyOnel2', 'user[email]' => 'FendyOnel2@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
    assert_equal '/profile', path
    delete destroy_user_session_path
    delete destroy_user_path

    post user_session_path, 'user[email]' => 'FendyOnel2@gmail.com', 'user[password]' => '123123123'
    get_via_redirect "/waitlists_new?rest_id=@user.id"
    assert_equal '/waitlists_new', path

    #tear down
    delete destroy_user_session_path
    delete destroy_user_path
  end

   test "login waitlist restaurant not yet sign in" do
    https!
    get "/restaurants"
    assert_response :success

    delete destroy_user_session_path
    get_via_redirect waitlists_path
    assert_equal '/login', path
   end

  test "create new restaurant" do
    https!
    get "/restaurants"
    assert_response :success

    #create user test
    post_via_redirect create_restaurant_path, 'user[name]' => 'FendyBilly', 'user[email]' => 'FendyBilly@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
    assert_equal '/profile', path

    #sign in test
    post_via_redirect user_session_path, 'user[email]' => 'FendyBilly@gmail.com', 'user[password]' => '123123123'
    assert_equal '/profile', path

    #tear down
    delete destroy_user_session_path
    delete destroy_user_path
   end

  test "count how many restaurants" do
    #create user test
    assert_difference('Restaurant.count', 1) do
        post '/create-restaurant', 'user[name]' => 'Billy1', 'user[email]' => 'Billy1@gmail.com', 'user[password]' => '1235abcd', 'user[password_confirmation]' => '1235abcd'
        get '/signup-restaurant'
    end

    #tear down
    delete destroy_user_session_path
    delete destroy_user_path
   end

end