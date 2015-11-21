class Customer < ActiveRecord::Base
	belongs_to :user
	has_many :waitlist
    has_many :cart, :foreign_key => 'cust_id', :primary_key => 'user_id'

    
end
