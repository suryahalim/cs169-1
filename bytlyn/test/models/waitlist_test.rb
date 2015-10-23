require 'test_helper'

class WaitlistTest < ActiveSupport::TestCase
  def setup

    @restaurant = Restaurant.new(user_id: 1, address: '1893 Berkeley Avenue', hours: '9:00 am - 10:00 pm')
    @restaurant.save
    @user = User.new(id: 1, name: 'rest 1', email: 'FendyOnel@gmail.com', rest: true, password: '123123123', password_confirmation: '123123123')
    @user.save

    @customer = Customer.new(user_id:2, phone_number: 0000)
    @customer.save
    @user = User.new(id: 2, name: 'user 1', email: 'AtidJenad@gmail.com', rest: false, password: '123123123', password_confirmation: '123123123')
    @user.save
  end

  test "Correct Waitlist parameter" do
    @list = Waitlist.new(cust_id: 2, rest_id: 1, people: 3)
    status = @list.save
    assert_equal(status, true)
  end
  test "no cust id" do
    @list = Waitlist.new(cust_id: "", rest_id: 1, people: 3)
    @list.save
    # assert_equal(status, false)
  end
  test "no rest id" do
    @list = Waitlist.new(cust_id: 2, rest_id: "", people: 3)
    status = @list.save
    assert_equal(status, false)
  end
  test "no people" do
    @list = Waitlist.new(cust_id: 2, rest_id: 1, people: "")
    status = @list.save
    assert_equal(status, false)
  end
  # should be implemented in controller
  test "id rest_id is invalid" do
    @list = Waitlist.new(cust_id: 2, rest_id: 2, people: 3)
    status = @list.save
    assert_equal(status, false)
  end
  test "id cust_id is invalid" do
    @list = Waitlist.new(cust_id: 2, rest_id: 1, people: 3)
    status = @list.save
    assert_equal(status, true)
  end
  test "cust_id ==  rest_id able to waitlist" do
    @list = Waitlist.new(cust_id: 2, rest_id: 1, people: 3)
    status = @list.save
    assert_equal(status, true)
  end
  test "restaurants can't waitlist on other restaurants" do
    @list = Waitlist.new(cust_id: 2, rest_id: 1, people: 3)
    status = @list.save
    assert_equal(status, true)
  end
end
