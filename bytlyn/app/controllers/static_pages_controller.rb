class StaticPagesController < ApplicationController
    def index
        render "index.html"
    end

    def login
        render "login.html"
    end

    def signup
        render "signup.html"
    end

    def signup_rest
        render "signup-restaurant.html"
    end
end
