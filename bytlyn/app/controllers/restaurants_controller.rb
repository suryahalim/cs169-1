require "net/http"
require "uri"
class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  # GET /restaurants
  # GET /restaurants.json
  def index
      @restaurants = Restaurant.all
      @users = User.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    if user_signed_in?
      if current_user.rest && Restaurant.find_by_user_id(current_user.id) == nil
        @restaurant = Restaurant.new
        7.times {@restaurant.hours.build}
      else
        redirect_to profile_path, notice: 'Restricted Path'
      end
    else
      redirect_to signed_in_path, notice: 'Restricted Path'
    end
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    # render text: restaurant_params
    url = "http://api.zippopotam.us/us/" + restaurant_params[:zip]
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    if response.body == nil or response.body.empty? or response.body == '{}'
      flash[:error] = "restaurant zip code not valid"
      redirect_to restaurant_new_path
      return
    else 
      response = JSON.parse(response.body)
      place = response['places']
      a = {}
      a[:lat] = place[0]['latitude']
      params[:restaurant][:lat] = place[0]['latitude']
      params[:restaurant][:lon] = place[0]['longitude']
    end

    @restaurant = Restaurant.new(restaurant_params)
    hours = restaurant_params[:hours_attributes]
    @hour = []
    hours.each  do |k, v|
      v[:day_id] = k.to_i + 1
      v[:rest_id] = restaurant_params[:user_id]
      @hour << Hour.new(v)
    end

    
    @hour.each do |h|
      if !h.valid? 
        flash[:error] = "Opening Hours Not Valid. Either both open and close hour should be empty or closing hour >= opening hour"
        redirect_to restaurant_new_path
        return
      end
    end
    if !@restaurant.valid?
      flash[:error] = "restaurant details not valid"
      redirect_to restaurant_new_path
      return
    end

    @hour.each do |h|
      h.save
    end

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to profile_path, notice: 'Restaurant was successfully created.'}
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
    def hours_params
      params.require(:hours).permit(:close, :hour)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      # params[:restaurant]
      params.require(:restaurant).permit(:address, :city, :zip, :hours, :user_id, :rest_type, :price, :description, :lon, :lat,hours_attributes: [:day_id, :open, :close, :rest_id])
    end
end
