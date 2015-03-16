class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome to you reader profile page. Here you can view your bookmarks, comments, and permission."
			redirect_to @user
		else
			render 'new'
		end
	end
	
	private 
		
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end

end
