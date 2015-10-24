require 'test_helper'


class UsersIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @customer = Customer.new(user_id:2, phone_number: 0000)
    @customer.save
    @user = User.new(id: 2, name: 'user 1', email: 'AtidJenad@gmail.com', rest: false, password: '123123123', password_confirmation: '123123123')
    @user.save
  end
  

  test "sign up customer user successfully" do
    assert_no_difference('Restaurant.count') do 
      assert_difference [ 'User.count', 'Customer.count' ], 1 do
        post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => 'FendyBilly@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
        assert_response :success
        assert_equal '/profile', path
      end
    end
  end

  test "sign up restaurant user successfully" do
    assert_no_difference('Customer.count') do 
      assert_difference [ 'User.count', 'Restaurant.count' ], 1 do
        post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => 'FendyBilly@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
        assert_response :success
        assert_equal '/profile', path
      end
    end
  end

  test "sign in  user successfully" do
    post_via_redirect "/sign_in", 'user[email]' => 'AtidJenad@gmail.com', 'user[password]' => '123123123'
    assert_equal '/profile', path
  end

  test "sign up user failure no email" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => '', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-user', path
    end
  end
  test "sign up user failure email regex bad" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => 'asdf', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-user', path
    end
  end

  test "sign up user failure password < 8" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => 'user@gmail.com', 'user[password]' => '123123', 'user[password_confirmation]' => '123123'
      assert_response :success
      assert_equal '/signup-user', path
    end
  end

  test "sign up user failure password don't match" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => 'user@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123111'
      assert_response :success
      assert_equal '/signup-user', path
    end
  end

  test "sign up rest failure no email" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => '', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-restaurant', path
    end
  end
  test "sign up rest failure email regex bad" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => 'asdf', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-restaurant', path
    end
  end

  test "sign up rest failure password < 8" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => 'user@gmail.com', 'user[password]' => '123123', 'user[password_confirmation]' => '123123'
      assert_response :success
      assert_equal '/signup-restaurant', path
    end
  end

  test "sign up rest failure password don't match" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => 'user@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123111'
      assert_response :success
      assert_equal '/signup-restaurant', path
    end
  end

  test "sign up user duplicate failure" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-user", 'user[name]' => 'FendyBilly', 'user[email]' => 'AtidJenad@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-user', path
    end
  end

  test "sign up restaurant duplicate failure" do
    assert_no_difference([ 'User.count', 'Restaurant.count', 'Customer.count' ]) do 
      post_via_redirect "/create-restaurant", 'user[name]' => 'FendyBilly', 'user[email]' => 'AtidJenad@gmail.com', 'user[password]' => '123123123', 'user[password_confirmation]' => '123123123'
      assert_response :success
      assert_equal '/signup-restaurant', path
    end
  end

  test "sign in  user don't exist" do
    post_via_redirect "/sign_in", 'user[email]' => 'userdontexist@gmail.com', 'user[password]' => '123123123'
    assert_response :success
    assert_equal '/sign_in', path
  end

  test "sign in wrong password" do
    post_via_redirect "/sign_in", 'user[email]' => 'AtidJenad@gmail.com', 'user[password]' => '123123122'
    assert_response :success
    assert_equal '/sign_in', path
  end
end
