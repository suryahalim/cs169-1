class DynamicPagesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :login, :signup, :signup_rest, :signup_user, :home]

    def profile
        render "profile.html.erb"
    end

    def index
    end

    def login
    end

    def signup
    end

    def signup_rest
        render "signup-restaurant.html"
    end

    def signup_user
        render "signup-user.html"
    end

    def home
        if user_signed_in?
            redirect_to profile_path
        else
            redirect_to index_path
        end
    end

end
