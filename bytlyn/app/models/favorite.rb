class Favorite < ActiveRecord::Base
	validates :cust_id, presence: true
    validates :rest_id, presence: true
	belongs_to :customer

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	validates :rest_id, presence: true

    def self.get_restaurant_favorite(user_id)
		if Restaurant.where(cust_id: user_id).first != nil
	        return Restaurant.where(rest_id: user_id).order(:created_at)
	    else
	    	return false
	    end
    end
end
