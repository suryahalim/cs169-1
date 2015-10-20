class Waitlist < ActiveRecord::Base


    def self.get_restaurant_waitlist(user_id)
        return Waitlist.where(rest_id: user_id).order(:created_at)
    end

    def self.get_customer_waitlist(user_id)
        list_and_position = []
        lists = Waitlist.where(cust_id: user_id).order(:created_at)
        lists.each do |list|
            this_list = get_restaurant_waitlist(list.rest_id)
            pos = this_list.count(:conditions => ['created_at < ?', list.created_at])
            list_and_position << {:list => list, :position => pos}
        end
        return list_and_position
    end


end
