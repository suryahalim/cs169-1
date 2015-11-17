class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    if user_signed_in? and current_user.rest
      if Restaurant.find_by_user_id(current_user.id) != nil
        @lists = Favorite.get_restaurant_favorite(current_user.id)
        render 'index.html.erb' 
      else
        redirect_to restaurant_new_path
      end

      # else
      #   @waitlists = Waitlist.get_customer_waitlist(current_user.id)
      #   render 'cust_index.html.erb'   
    else
      redirect_to login_path
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    if user_signed_in? and current_user.rest
      @favorite = Favorite.new
    else
      redirect_to login_path
    end
  end

  # GET /menus/1/edit
  def edit
    if user_signed_in? and current_user.rest
      render 'new.html.erb'
    else
      redirect_to login_path
    end
  end

  # POST /favorite
  # POST /favorite.json
  def create
    @favorite = Favorite.new(menu_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to favorite_path, notice: 'Favorite was successfully added 1.' }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite/1
  # PATCH/PUT /favorite/1.json
  def update
    respond_to do |format|
      if @favorite.update(menu_params)
        format.html { redirect_to favorite_path, notice: 'Favorite was successfully added 2.' }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Restaurant was successfully removed from favorite list.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      if params[:id] != nil
        @favorite = Favorite.find(params[:id])
      else
        redirect_to login_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorites).permit(:rest_id, :user_id)
    end
end
end
