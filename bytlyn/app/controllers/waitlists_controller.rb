class WaitlistsController < ApplicationController
  before_action :set_waitlist, only: [:show, :edit, :update, :destroy]

  # GET /waitlists
  # GET /waitlists.json
  def index
    @waitlists = Waitlist.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render xml: @waitlists}
    #   format.json { render json: @waitlists}
    # end
  end

  # GET /waitlists/1
  # GET /waitlists/1.json
  def show
  end

  # GET /waitlists/new
  def new
    @waitlist = Waitlist.new
  end

  # GET /waitlists/1/edit
  def edit
  end

  # POST /waitlists
  # POST /waitlists.json
  def create
    cur_rest = params[:waitlist][:rest_id]
    cur_people = params[:waitlist][:people]
    # render text: params
    waitlist_params = {cust_id: current_user.id, rest_id: cur_rest, people: cur_people}
    @waitlist = Waitlist.new(waitlist_params)

    respond_to do |format|
      if @waitlist.save
        flash.now[:notice] = 'Waitlist was successfully created.'
        format.html { redirect_to profile_path, notice: 'Waitlist was successfully created.' }
        format.json { render :show, status: :created, location: @waitlist }
      else
        format.html { render :new }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waitlists/1
  # PATCH/PUT /waitlists/1.json
  def update
    respond_to do |format|
      if @waitlist.update(waitlist_params)
        format.html { redirect_to @waitlist, notice: 'Waitlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @waitlist }
      else
        format.html { render :edit }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waitlists/1
  # DELETE /waitlists/1.json
  def destroy
    @waitlist.destroy
    respond_to do |format|
      format.html { redirect_to waitlists_url, notice: 'Waitlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waitlist
      @waitlist = Waitlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waitlist_params
      # params[:waitlist]
      params.require(:waitlist).permit(:cust_id, :rest_id, :people)
    end
end
