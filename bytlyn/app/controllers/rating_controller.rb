class RatingController < ApplicationController

    def create
        if user_signed_in?
            if current_user.rest
                # show notif, rest cannot rate
            elsif Rating.where(:restaurant_id => rating_params[:restaurant_id], :customer_id => rating_params[:customer_id]).count > 0
                # show notif, you have rated
            else
                @rating = Rating.new(rating_params)
                @rating.save
            end
        end
        redirect_to(:back)
    end


  private
    def rating_params
        params.permit(:restaurant_id, :rating, :customer_id)
    end

end
