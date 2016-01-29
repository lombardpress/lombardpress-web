class Users::ProfilesController < ApplicationController
	before_filter :authenticate_user!
  

	def index
		#unless current_user.admin?
		 #	redirect_to "/permissions", :alert => "Access denied."
    #end
    @users = User.all
    @sorted_users = @users.sort_by {|row| row[:email]}
    @profile = User.new
    authorize @profile

	end
	def show
		@user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
    @general_comments = @comments.select {|comment| comment.access_type == 'general'}
    @personal_comments = @comments.select {|comment| comment.access_type == 'personal'}
    @editorial_comments = @comments.select {|comment| comment.access_type == 'editorial'}
		
    @profile = @user
		#note that user in the authorize method is actually the second arg
		#corresponding to the @profile arg in the pundit policy
		authorize @profile
  end
  def create
  	@profile = User.new(profile_params)
    authorize @profile 
    if @profile.save
      redirect_to users_profiles_path, :notice => "Profile successfully added"
    end
  end
  def update

  	@profile = User.find(params[:id])
    authorize @profile
    if @profile.update(profile_params)
			redirect_to users_profile_path(@profile), :notice => "Profile successfully update"
		end
  end
  def destroy 

  	@profile = User.find(params[:id])
    authorize @profile
    if @profile.destroy
			redirect_to users_profiles_path, :notice => "Profile successfully deleted"
		end
  end
  

  private 
	  def profile_params
	    params.require(:profile).permit(:email, :password, :role)
	  end

end