class Customer < ActiveRecord::Base
	belongs_to :user
	has_many :waitlist
    has_many :rating

    
end
