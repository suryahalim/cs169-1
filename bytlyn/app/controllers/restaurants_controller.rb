class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  # GET /restaurants
  # GET /restaurants.json
  def index
      @restaurants = Restaurant.all
      @users = User.all
  end

  def search
      # todo:
      # search all column
      # search each word: http://stackoverflow.com/questions/6337381/search-on-multiple-keywords-in-a-single-search-text-field-rails
      # search by relevance
      # autocomplete: https://rubygems.org/gems/autocomplete/versions/1.0.2
      # advance: https://www.youtube.com/watch?v=eUtUquKc2qQ
      # pg full text search: https://www.youtube.com/watch?v=pfZw6yErsX0
      
      # gem choice :
      # textacular
#      render json: Restaurant.all
    resto = "b"
#    render json: Restaurant.joins(:user).where(["email LIKE ?", "%#{search_params[:key]}%"])
    @restaurants = Restaurant.joins(:user).where(["lower(name) LIKE ?", "%#{search_params[:key].downcase}%"])
#      @restaurants = Restaurant.find_by address: search_params[:key]
      # or .where("address = ? OR hours = ?", search_params[:key], search_params[:key])
      @users = User.all
      render "index"
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
    @restaurant = Restaurant.new(restaurant_params)
    hours = restaurant_params[:hours_attributes]
    @hour = []
    hours.each  do |k, v|
      v[:day_id] = k.to_i + 1
      @hour << Hour.new(v)
    end

    
    @hour.each do |h|
      if !h.valid? 
        flash[:error] = "Opening Hours Not Valid. Must not be empty and closing hour >= opening hour"
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
        format.html { redirect_to profile_path, notice: 'Restaurant was successfully created.' }
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
    
    def search_params
        params.permit(:key)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      # params[:restaurant]
      params.require(:restaurant).permit(:address, :hours, :user_id, :rest_type, :price, :description, hours_attributes: [:day_id, :open, :close, :rest_id])
    end
end
