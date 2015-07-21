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
  def json
    item = get_item(params)
    check_permission(item); return if performed?
    check_transcript_existence(item, params); return if performed?
    paragraph = item.transcription(wit: params[:msslug], source: "origin").paragraph(params[:pid])
    paragraph_text = paragraph.transform("#{Rails.root}/xslt/default/documentary/documentary_simple.xsl")
    #add compact at the end to exlude nil result for critical text
    ms_slugs = item.transcription_slugs.map {|slug| unless slug == params[:itemid] then slug.split("_").first end}.compact
      
    paragraph_hash = {
        :paragraph_text => paragraph_text.text.to_s.gsub(/\n/, '<br/> *'),
        :next_para => if paragraph.next != nil then paragraph.next.pid else nil end,
        :previous_para => if paragraph.previous != nil then paragraph.previous.pid else nil end,
        :paragraph_number => paragraph.number,
        :ms_slugs => ms_slugs,
        :pid => params[:pid],
        :itemid => params[:itemid],
        :commentaryid => @config.commentaryid,
      }

    
    render :json => paragraph_hash
  
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
  def variants
    item = get_item(params)
    check_permission(item); return if performed?
    check_transcript_existence(item, params); return if performed?
    transcript = get_transcript(item, params)
    xslt_param_array = ["pid", "'#{params[:pid]}'"]
    @para_variants = transcript.transform("#{Rails.root}/xslt/default/critical/para_variants.xsl", xslt_param_array)
    render :layout => false
  end
end
