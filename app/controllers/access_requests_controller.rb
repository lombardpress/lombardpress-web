class AccessRequestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_access_request, only: [:show, :edit, :update, :destroy]

  # GET /access_requests
  # GET /access_requests.json
  def index
    @access_requests = AccessRequest.all
    authorize @access_requests.first
  end

  # GET /access_requests/1
  # GET /access_requests/1.json
  def show
    #@access_request = AccessRequest.find(params[:id])
    authorize @access_request
  end

  # GET /access_requests/new
  def new
    @access_request = AccessRequest.new
    authorize @access_request
  end

  # GET /access_requests/1/edit
  def edit
  end

  # POST /access_requests
  # POST /access_requests.json
  def create

    @access_request = AccessRequest.new(access_request_params)
    @access_request.open!
    @user = User.find(access_request_params[:user_id])
    respond_to do |format|
      if @access_request.save
        #confirm_request sends email to user who requested access
        AccessMailer.confirm_request_access(@user, access_request_params[:itemid], access_request_params[:commentaryid], @config.confighash).deliver_now
        # request access sends email to editor (currently "me")
        AccessMailer.request_access(@user, access_request_params[:itemid], access_request_params[:commentaryid]).deliver_now
        
        format.html { redirect_to @access_request, notice: 'Access request was successfully created.' }
        format.json { render :show, status: :created, location: @access_request }
      else
        format.html { render :new }
        format.json { render json: @access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_requests/1
  # PATCH/PUT /access_requests/1.json
  def update
    respond_to do |format|
      if @access_request.update(access_request_params)
        format.html { redirect_to @access_request, notice: 'Access request was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_request }
      else
        format.html { render :edit }
        format.json { render json: @access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_requests/1
  # DELETE /access_requests/1.json
  def destroy
    @access_request.destroy
    respond_to do |format|
      format.html { redirect_to access_requests_url, notice: 'Access request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_request
      @access_request = AccessRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_request_params
      params.require(:access_request).permit(:user_id, :itemid, :commentaryid, :note)
    end
end
