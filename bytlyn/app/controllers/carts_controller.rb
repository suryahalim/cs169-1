class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  def version_check(params)
    cust = params[:cust_id]
    rest = params[:rest_id]
    @cur_version = {cust_id: cust, rest_id: rest}
    @version = Version.where(cust_id: cust, rest_id: rest).first
    if @version == nil
      @cur_version[:count] = 0
      Version.create(@cur_version)
      return 0
    end
    return @version.count
  end

  def qty_check(params)
    cust = params[:cust_id]
    rest = params[:rest_id]
    menu = params[:menu_id]
    ver = params[:version]
    @cur_cart = Cart.where(cust_id: cust, rest_id: rest, menu_id: menu, version: ver).first
    if @cur_cart == nil
      # render json: params
      return false
    end
    params[:qty] = @cur_cart.qty + 1
    @cur_cart.update(params)
    return true
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    @cart.version = version_check(cart_params)
    # cart_params[:version] = @cart.version
    topass = cart_params
    topass[:version] = @cart.version
    # topass = {cust_id: cart_params[:cust_id], rest_id: cart_params[:rest_id], menu: cart_params[:menu_id], version: @cart.version}
    
    # render json: @cart
    if !qty_check(topass)
      @cart.qty = 1
      # render json: topass
      respond_to do |format|
        if @cart.save
          # link = '/restaurant_page?rest_id=' + params[:rest_id].to_s
          format.html { redirect_to restaurants_path}
          # format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to carts_path
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:cust_id, :rest_id, :version, :menu_id, :qty)
    end
end
