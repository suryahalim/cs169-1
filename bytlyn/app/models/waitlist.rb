class Waitlist < ActiveRecord::Base
	belongs_to :customer
	belongs_to :restaurant
	belongs_to :user
end
