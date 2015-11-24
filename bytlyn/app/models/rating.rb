class Rating < ActiveRecord::Base
    belongs_to :restaurant
    
    def self.average_rating(rest_id)
        Rating.where(:restaurant_id => rest_id).average(:rating)
    end

    def self.rate_exist(rest_id,cust_id)
        Rating.where(:restaurant_id => rest_id, :customer_id => cust_id).count > 0
    end
end
