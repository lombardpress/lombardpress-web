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
      # not that by doing the folloing each loop, you could be 
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
        
      end
      
      
    end
    ## at the moment this authorization,
    ## this auth simply double checks to make sure the user
    ## is either an admin or use. In otherwords is not an anonymous user.
    authorize @comments[0]

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
      redirect_to @comment, :notice => "Post successfully created"
    else
      # note that without resending this params, they are not available.
      set_required_params
      #render new needs to include itemid and paragraphid
      render 'new'
    end
  end

  def list
    set_required_params
    @comments = Comment.where itemid: params[:itemid], pid: params[:pid]
    
  end

  def show
  end


  def edit
  end

  def update
  end

  def destroy
  end

  private 
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :pid, :itemid, :commentaryid)
  end
  def set_required_params
    config_hash = @config.confighash
    commentaryid = @config.commentaryid
    url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"

    params[:user] = current_user[:id]
    params[:commentaryid] = @config.commentaryid
    
    @item = Lbp::Item.new(config_hash, url)
    
    # Lbp should create a separate class for Paragraph and TranscriptParagraph
    # I should be able to retrieve paragraph number from SCTA rather than having to count it from the file
    # since paragraphs numbers are currently being counted from critical file, we need to check and see if there is a critical file
    # this would no longer be needed if paragraph number was coming from the SCTA databse.
    if @item.transcription?("critical")
      @paragraph = @item.transcription(source: "origin").paragraph(params[:pid])
    end
    
  end

end
