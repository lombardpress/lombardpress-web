class AccessPointsController < ApplicationController
	before_filter :authenticate_user!
	def show

		@access_point = AccessPoint.find_by(access_params)
		authorize @access_point
	end
	def create
		user = User.find(params[:id])
		
		if ap = AccessPoint.find_by(access_params)
			authorize ap
			user.access_points << ap
		else
			ap = AccessPoint.new(access_params)
			authorize ap
			ap.save
			user.access_points << ap
		end
		redirect_to users_profile_path(user), :notice => "Access Point successfully added"
  	
  end
  def destroy 
		user = User.find(params[:id])
		ap = AccessPoint.find_by(access_params)
		authorize ap
		user.access_points.delete(ap)
    redirect_to users_profile_path(user), :notice => "Access point successfully deleted"
	end

  private 
	  def access_params
	    params.require(:access_point).permit(:itemid, :commentaryid)
	  end
end