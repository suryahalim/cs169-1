class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  #signup user
  def signupuser
    account_params
    @my_params["rest"] = "false"
    @account = Account.new(@my_params)
    if @account.save
      # log_in @account
      # flash[:success] = "Thank you for signing up!"
      render json: {status: "success"}
      return
      # redirect_to @account
      #goto logged in page
    else
      render json: {status: "fail"}
      #go back display error message
    end
  end

  def signuprest
    account_params
    @my_params["rest"] = "true"
    @account = Account.new(@my_params)
    @account = Account.new(account_params, :rest => true)
    if @account.save
      #goto logged in page
    else
      #go back display error message
    end
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      @my_params = params.permit(:email, :name, :password, :password_confirmation)
    end
end
