class HoursController < ApplicationController
    def create
    # render text: restaurant_params
    @hour = Hour.new(hour_params)
    @restaurant = @hour.restaurant
    respond_to do |format|
      if @hour.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end
end
