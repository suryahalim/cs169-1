require 'test_helper'

class RatingRoutesTest < ActionDispatch::IntegrationTest
    
    # initial setup
     def setup
      @restaurant = Restaurant.new("description"=>"123", "price"=>"1", "address"=>"123", "rest_type"=>"Italian", "zip" =>"94704", "city" =>"berkeley", "hours_attributes"=>{"0"=>{"open"=>"11:11", "close"=>"11:11", "rest_id"=>"90", "day_id"=>"1"}, "1"=>{"open"=>"14:22", "close"=>"14:22", "rest_id"=>"90", "day_id"=>"2"}, "2"=>{"open"=>"15:32", "close"=>"15:33", "rest_id"=>"90", "day_id"=>"3"}, "3"=>{"open"=>"03:22", "close"=>"15:32", "rest_id"=>"90", "day_id"=>"4"}, "4"=>{"open"=>"16:44", "close"=>"21:09", "rest_id"=>"90", "day_id"=>"5"}, "5"=>{"open"=>"18:06", "close"=>"19:07", "rest_id"=>"90", "day_id"=>"6"}, "6"=>{"open"=>"08:08", "close"=>"20:08", "rest_id"=>"90", "day_id"=>"7"}}, "user_id"=>"90")
      @user = User.create(id: 2, name: 'user 1', email: 'AtidJenad@gmail.com', rest: false, password: '123123123', password_confirmation: '123123123')
      @user.save
      @restaurant.save
      
      # create user as restaurant and populate into database
      @user_rest = User.create(name: "test2", email: "test2@gmail.com", password:"foobar12", password_confirmation: "foobar12",
              rest: true)
      @user_rest2 = User.create(name: "test1", email: "test1@gmail.com", password:"foobar13", password_confirmation: "foobar13",
              rest: true)
      @rest = Restaurant.create(user_id: @user_rest.id)
      @rest1 = Restaurant.create(user_id: @user_rest2.id)
      @user_rest.save
      @user_rest2.save
      @rest1.save
      @rest.save

      post_via_redirect "/sign_in", 'user[email]' => @user.email, 'user[password]' => @user.password
    end

    # user can access waitlist page after sign in
#    test "a" do
#        get 'restaurant_page?rest_id=' + @restaurant.id.to_s
#        post '/rate', { restaurant_id: @restaurant.id, customer_id: @customer.id, rating: 2}
#        assert_not_nil Rating.where(customer_id: @customer.id,restaurant_id: @restaurant.id).first
#    end

   test "b" do
       #get '/restaurants'
       post rate_path
       assert_response :redirect
       post '/rate', rating: { restaurant_id: @restaurant.id, customer_id: @user.id, rating: 2}
       assert_not_nil Rating.where(restaurant_id: @restaurant_id)
   end

end