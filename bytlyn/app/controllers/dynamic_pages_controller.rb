class DynamicPagesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :login, :signup, :signup_rest, :signup_user, :home]

    def profile
        if current_user.rest
            render "profile-resto.html.erb"
        else
            render "profile.html.erb"
        end
    end

    def index
    end

    def signup
    end

    def home
        if user_signed_in?
 
            redirect_to profile_path

        else
            redirect_to index_path
        end
    end

end
