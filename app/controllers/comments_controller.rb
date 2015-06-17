class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:list, :show]
  def index
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
