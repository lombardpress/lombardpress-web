class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:list, :show]
  def index
    if current_user.admin?
      @comments = Comment.all
    else
    # this little map block is copied from "check permissions" functions
    # in text methods. It should be refactored to avoid redundancy
      allowed_texts = current_user.access_points.map do  |access_point|
        if access_point.editor?
          {itemid: access_point.itemid,
          commentaryid: access_point.commentaryid}
        end
      end
      allowed_texts.compact!
      @comments = []
      # note that by doing the folloing each loop, you could be
      # hitting the database several times
      # it might better to get an array of acceptable values all
      # at once and then hit the database more than once
      # but this is more complicated
      allowed_texts.each do |allowed|
        if allowed[:itemid] == 'all'
          results = Comment.where(commentaryid: allowed[:commentaryid])
        else
         results = Comment.where(commentaryid: allowed[:commentaryid], itemid: allowed[:itemid])
        end
        @comments << results
        @comments.flatten!
        #use this remove personal/privates comments from results unless they belong to the current user
        @comments = @comments.select {|comment| comment.access_type != 'personal' || (comment.access_type == 'personal' && comment.user_id == current_user.id) }

      end


    end
    ## at the moment this authorization,
    ## this auth simply double checks to make sure the user
    ## is either an admin or user. In otherwords, it only checks against an anonymous user.
    if @comments.count > 0
      authorize @comments[0]
    end

  end

  def new
    set_required_params
    @comment = Comment.new
    authorize @comment

  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      #send_ldn performs a post to lnd inbox for this resource;
      #comment out if this functionality is not desired.
      if comment_params[:access_type] == 'general'
        @comment.send_ldn(comment_params)
      end
      
      render 'show'
    else
      # note that without resending this params, they are not available.
      set_required_params
      #render new needs to include itemid and paragraphid
      render 'new'
    end
  end

  def list
    set_required_params

    if params[:pid] == nil
       @comments = Comment.where itemid: params[:itemid]
     else
      @comments = Comment.where itemid: params[:itemid], pid: params[:pid]
    end

    @general_comments = @comments.select {|comment| comment.access_type == 'general'}
    @editorial_comments = @comments.select {|comment| comment.access_type == 'editorial'}
    #turn this conditional oof you do not want admin to be able to see private notes
      if current_user.admin?
        @personal_comments = @comments.select {|comment| comment.access_type == 'personal'}
      else
      @personal_comments = @comments.select {|comment| comment.access_type == 'personal' && comment.user_id == current_user.id }
      end

  end

  def show
  end


  def edit
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    rt = redirect_target
    if rt[:redirect_target] == "index"
      redirect_to comments_path, :notice => "Comment sucessfully deleted"
    elsif rt[:redirect_target] == "profile"
      redirect_to users_profile_path @comment.user_id, :notice => "Comment sucessfully deleted"
    else
      redirect_to list_comments_path comment_params[:itemid], :notice => "Comment sucessfully deleted"
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :pid, :itemid, :commentaryid, :access_type)
  end
  def set_required_params
    config_hash = @config.confighash
    commentaryid = @config.commentaryid
    url = "http://scta.info/resource/#{params[:itemid]}"

    params[:user] = current_user[:id]
    params[:commentaryid] = @config.commentaryid

    @expression = Lbp::Expression.find(url)

    # Lbp should create a separate class for Paragraph and TranscriptParagraph
    # I should be able to retrieve paragraph number from SCTA rather than having to count it from the file
    # since paragraphs numbers are currently being counted from critical file, we need to check and see if there is a critical file
    # this would no longer be needed if paragraph number was coming from the SCTA databse.
    #if @item.transcription?("critical")
    #  @paragraph = @item.transcription(source: "origin").paragraph(params[:pid])
    #end
  end
  # this parameter is used to let me redirect use to different places after a comment has
  # been successfully deleted
  def redirect_target
    return params.require(:comment).permit(:redirect_target)
  end

end
