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
    item = get_item(params)
    @parts = item.transcription_slugs.map do |part| 
      if part.include? "_"
        part.split("_").first
      else
        "critical"
      end
    end
    
    if params[:base].nil? or params[:base] == ""
      @base_text_name = nil
      @para_base
    else
      @base_text_name = params[:base]
      base_transcript = item.transcription(source: "origin", wit: @base_text_name)
      @para_base = base_transcript.paragraph(params[:pid]).transform_plain_text.text
    end
    if params[:comp].nil? or params[:comp] == ""
      @comp_text_name = nil
      @para_comp = nil
    else
      @comp_text_name = params[:comp]
      comp_transcript = item.transcription(source: "origin", wit: @comp_text_name)
      @para_comp = comp_transcript.paragraph(params[:pid]).transform_plain_text.text
    end

    render :layout => false

  end
end
