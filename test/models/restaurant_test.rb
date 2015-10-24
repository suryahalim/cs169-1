require 'test_helper'
# require File.dirname(__FILE__) + '/../test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :restaurants

  def test_user_id

    rest = Restaurant.new :user_id => restaurants(:rest_input).user_id, 
                          :address => restaurants(:rest_input).address,
                          :hours => restaurants(:rest_input).hours

    assert rest.save

    rest_copy = Restaurant.find(rest.id)

    assert_equal rest.user_id, rest_copy.user_id

    rest.user_id = 1

    assert rest.save
    assert rest.destroy
  end

  def test_address

    rest = Restaurant.new :user_id => restaurants(:rest_input).user_id, 
                          :address => restaurants(:rest_input).address,
                          :hours => restaurants(:rest_input).hours

    assert rest.save

    rest_copy = Restaurant.find(rest.id)

    assert_equal rest.address, rest_copy.address

    rest.user_id = "1893 Berkeley Avenue"

    assert rest.save
    assert rest.destroy
  end

  def test_hours

    rest = Restaurant.new :user_id => restaurants(:rest_input).user_id, 
                          :address => restaurants(:rest_input).address,
                          :hours => restaurants(:rest_input).hours

    assert rest.save

    rest_copy = Restaurant.find(rest.id)

    assert_equal rest.hours, rest_copy.hours

    rest.user_id = "9:00 am - 10:00 pm"

    assert rest.save
    assert rest.destroy
  end

  def test_count

    rest = Restaurant.new :user_id => restaurants(:rest_input).user_id, 
                          :address => restaurants(:rest_input).address,
                          :hours => restaurants(:rest_input).hours

    assert rest.save

    # rest_copy = Restaurant.find(rest.id)
    rest_count = Restaurant.count

    assert_equal 2, rest_count

    assert rest.save
    assert rest.destroy
  end

































end
