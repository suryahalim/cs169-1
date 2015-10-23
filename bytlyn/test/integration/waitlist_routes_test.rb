require 'test_helper'

class WaitlistRoutesTest < ActionDispatch::IntegrationTest
	# include Devise::TestHelpers
  	# test "the truth" do
  	#   assert true
  	# end
  	fixtures :all

  	def setup
	  @cust = User.create(name: "test1", email: "test1@gmail.com", password:"foobar11", password_confirmation: "foobar11",
	  			rest: false)
	  @cust.save
	  @rest = User.create(name: "test2", email: "test2@gmail.com", password:"foobar12", password_confirmation: "foobar12",
	  			rest: true)
	  @rest.save
	  @user = { email: @cust.email,
	           password: @cust.password}
	  # post "/sign_in", session: user
	  post user_session_path, session: User.find_by_id(@cust.id)
	  	# post "/sign_in", session: @user
	end

	test "user unable to waitlist before sign in" do
		
		# session[:user_id] = @cust.id
		# log_in user
	   	# assert_response :success
	    # assert_not_nil User.where(id: @cust.id)
	  	# assert_redirected_to profile_path
	  	get profile_path
	  	assert_response :success
	    # assert_redirected_to login_path
	    # assert_not_nil session[:user]
	end

	test "open waitlist path after sign in" do
	  get waitlists_new_path
	  assert_response :success
	end


end
