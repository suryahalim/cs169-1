class Menu < ActiveRecord::Base
	belongs_to :restaurant
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
	validates :rest_id, presence: true
	validates :name, presence: true
    validates :price, presence: true
	
	validates_attachment :avatar,
	content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
	size: { less_than: 5.megabytes}
	
	def self.get_restaurant_menu(user_id)
		if Restaurant.where(user_id: user_id).first != nil
	        return Menu.where(rest_id: user_id).order(:created_at)
	    else
	    	return false
	    end
    end
end
