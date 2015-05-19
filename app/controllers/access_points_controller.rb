class AccessPointsController < ApplicationController
	before_filter :authenticate_user!
	def show

		@access_point = AccessPoint.find_by(access_params)
		authorize @access_point
	end
	def create
		user = User.find(params[:id])
		# first check to see if access point exists; if it does check to see if user already has access
		if ap = AccessPoint.find_by(access_params)
			authorize ap
			unless user.access_points.include?(ap)
				user.access_points << ap
				#sends email only if a new access point is made; 
				#should not send email if duplicate is accidentally attempted
				AccessMailer.grant_access(user, access_params[:itemid], access_params[:commentaryid], @config.confighash).deliver_now
			end
		#if access point does not exist, create it and then assign it. No need to check if access point
		#is already assigned becuase it is impossible to already be assigned if access point does not yet exist	
		else
			ap = AccessPoint.new(access_params)
			authorize ap
			ap.save
			user.access_points << ap
			#sends email only if a new access point is made
			AccessMailer.grant_access(user, access_params[:itemid], access_params[:commentaryid], @config.confighash).deliver_now
		end
		#change status of request to closed if an request was opened
		if ar = AccessRequest.find_by(user_id: user.id, itemid: access_params[:itemid], commentaryid: access_params[:commentaryid], status: 0)
			ar.closed!
		end
		# redirect user
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