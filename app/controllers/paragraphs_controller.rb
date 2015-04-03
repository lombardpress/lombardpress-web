class ParagraphsController < ApplicationController
  include TextMethods
  def index
  end

  def show
    item = get_item(params)
    check_permission(item); return if performed?
    check_transcript_existence(item, params); return if performed?
    transcript = get_transcript(item, params)
    @p = transcript.paragraph(params[:pid]).transform_plain_text
  end

  def xml
    item = get_item(params)
    check_permission(item)
    transcript = get_transcript(item, params)
    @p = transcript.paragraph(params[:pid]).xml
    
  end

  def info
  end

  def plaintext
  end

  def collation
  end
end
