class PostsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show]
	
	def index
		@posts = Post.all
	end
	def list
		@posts = Post.all
		authorize @posts
	end
	
	def show 
		@post = Post.find(params[:id])
		#@user = User.find(@post[:user_id])
	end
	def new

		params[:user] = current_user[:id]
 		params[:commentaryid] = Rails.application.config.commentaryid
 		@post = Post.new
 		authorize @post
	end
	def edit
		params[:user] = current_user[:id]
 		params[:commentaryid] = Rails.application.config.commentaryid
		@post = Post.find(params[:id])
		authorize @post
	end
	def create
		@post = Post.new(post_params)
		if @post.save
    	redirect_to @post, :notice => "Post successfully created"
  	else
  		# note that without resending this params, they are not available.
  		params[:user] = current_user[:id]
 			params[:commentaryid] = Rails.application.config.commentaryid
    	render 'new'
  	end
	end
	
	def update
		@post = Post.find(params[:id])
		authorize @post

		if @post.update(post_params)
			redirect_to @post, :notice => "Post successfully updated"
		else
			params[:user] = current_user[:id]
 			params[:commentaryid] = Rails.application.config.commentaryid
			render 'edit'
		end

	end
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path, :notice => "Post sucessfully deleted"
	end
	
	private 
	
	
	def post_params
  	
  	params.require(:post).permit(:title, :body, :user_id, :commentaryid)
  end

end
