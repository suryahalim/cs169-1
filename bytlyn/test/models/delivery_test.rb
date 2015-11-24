require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  setup do
    @restaurant = Restaurant.new(user_id: 1, address: '1893 Berkeley Avenue')
    @restaurant.save
    @user = User.new(id: 1, name: 'rest 1', email: 'FendyOnel@gmail.com', rest: true, password: '123123123', password_confirmation: '123123123')
    @user.save

    @customer = Customer.new(user_id:2, phone_number: 0000)
    @customer.save
    @user = User.new(id: 2, name: 'user 1', email: 'AtidJenad@gmail.com', rest: false, password: '123123123', password_confirmation: '123123123')
    @user.save

    @menu1 = Menu.new(id: 1, rest_id: 1, name: 'test1', price: 2.5)
    @menu1.save

    @menu2 = Menu.new(id: 2, rest_id: 1, name: 'test2', price: 3.5)
    @menu2.save

    @version = Version.new(id: 1, cust_id: 2, rest_id: 1, count: 0)
    @version.save

    @cart1 = Cart.new(cust_id:2, rest_id: 1, version: 0, menu_id: 1, qty: 1)
    @cart1.save

    @cart2 = Cart.new(cust_id:2, rest_id: 1, version: 0, menu_id: 2, qty: 1)
    @cart2.save

  end

  test "get delivery cust" do
    @delivery1 = Delivery.new(phone: "20203020", rest_id: 1, version: 0, user_id: 2, address: "jalan jeruk", total: 6, status: 1)
    @delivery1.save
    @delivery2 = Delivery.new(phone: "2020300", rest_id: 1, version: 0, user_id: 3, address: "jalan jeruk", total: 6, status: 1)
    @delivery2.save
    assert_equal(Delivery.get_delivery_cust([2]).size, 1)
    assert_equal(Delivery.get_delivery_cust([2]).first, @delivery1)
    assert_equal(Delivery.get_delivery_cust([3]).size, 1)
    assert_equal(Delivery.get_delivery_cust([3]).first, @delivery2)
  end

  test "get delivery rest" do
    @delivery1 = Delivery.new(phone: "20203020", rest_id: 1, version: 0, user_id: 2, address: "jalan jeruk", total: 6, status: 1)
    @delivery1.save
    @delivery2 = Delivery.new(phone: "2020300", rest_id: 3, version: 0, user_id: 2, address: "jalan jeruk", total: 6, status: 1)
    @delivery2.save
    assert_equal(Delivery.get_delivery_rest([1]).size, 1)
    assert_equal(Delivery.get_delivery_rest([1]).first, @delivery1)
    assert_equal(Delivery.get_delivery_rest([3]).size, 1)
    assert_equal(Delivery.get_delivery_rest([3]).first, @delivery2)
  end

  test "get order carts" do
    @cart5 = Cart.new(cust_id:2, rest_id: 1, version: 1, menu_id: 1, qty: 1)
    @cart5.save

    @delivery1 = Delivery.new(phone: "20203020", rest_id: 1, version: 0, user_id: 2, address: "jalan jeruk", total: 6, status: 1)
    @delivery1.save

    arrays = Delivery.get_order(user_id: 2, rest_id: 1, version:0)
    assert_equal(arrays.size, 2)
  end
end