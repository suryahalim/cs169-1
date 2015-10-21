class Waitlist < ActiveRecord::Base
    validates :people, presence: true

    def self.get_restaurant_waitlist(user_id)
        return Waitlist.where(rest_id: user_id).order(:created_at)
    end

    def self.get_customer_waitlist(user_id)
        list_and_position = []
        lists = Waitlist.where(cust_id: user_id).order(:created_at)
        lists.each do |list|
            this_list = get_restaurant_waitlist(list.rest_id)
            pos = this_list.where('created_at < ?', list.created_at).count + 1
            # pos = this_list.count(:conditions => ['created_at < ?', list.created_at])
            list_and_position << {:list => list, :position => pos}
        end
        return list_and_position
    end

    def check_params
        if User.find(rest_id) == nil || !User.find(rest_id).rest
            errors.add(:rest_id, "Invalid restaurant id")
            return false
        end
        if (cust_id == rest_id) #for restaurant to put on their own waitlist
            return true
        end
        if Waitlist.where(cust_id: cust_id, rest_id: rest_id).size > 0
            errors.add(:base, "You have waitlisted on this restaurant")
            return false
        end
        return true
    end

end
