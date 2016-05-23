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
  def show2
    url = params[:url]
    @para = Lbp::ParagraphExemplar.new(@config.confighash, url)
    itemid = @para.itemid
    commentaryid = @para.cid
    pid = @para.pid
    commentaryurl = "http://scta.info/text/#{commentaryid}/commentary"
    commentary = Lbp::Collection.new(@config.confighash, commentaryurl)
    @commentary_title = commentary.title
    itemurl = "http://scta.info/text/#{commentaryid}/item/#{itemid}"
    @item = Lbp::Item.new(@config.confighash, itemurl)
    
    canonicalwit = @item.canonical_transcription_slug

    transcript = @item.transcription(source: "origin", wit: canonicalwit)
    
    @p = transcript.paragraph(pid).transform_plain_text
    render :layout => false
  end
  
  # TODO: text controller xml should work for this
  # so this should eventually be deleted and then an requests 
  # should be rerouted
  def xml
    #item = get_item(params)
    #check_permission(item)
    transcript = get_transcript(params)
    @p = transcript.file_part(@config.confighash, params[:pid]).xml
    
  end


  #TODO - not sure if this is being used. 
  # figure out if being its beings used and then delete
  def json
    #item = get_item(params)
    @expression = get_expression(params[:itemid])
    check_permission(@expression); return if performed?
    #check_transcript_existence(item, params); return if performed?
    #paragraph = item.transcription(wit: params[:msslug], source: "origin").paragraph(params[:pid])
    #paragraph_text = paragraph.transform("#{Rails.root}/xslt/default/documentary/documentary_simple.xsl")
    #add compact at the end to exlude nil result for critical text
    #ms_slugs = item.transcription_slugs.map {|slug| unless slug == params[:itemid] then slug.split("_").first end}.compact
      
    paragraph_hash = {
        :paragraph_text => @expressionparagraph_text.text.to_s.gsub(/\n/, '<br/> *').gsub(/\s+/, ' '),
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
    
    #item = get_item(params)
    @expression = get_expression(params[:itemid])
    
    @parts = @expression.manifestationUrls.map do |url|
      url.split("/").last
    end
    
    if params[:base].nil? or params[:base] == ""
      @base_text_name = nil
      @para_base = nil
    else
      @base_text_name = params[:base]
      base_params = {itemid: params[:itemid], msslug: params[:base]}
      base_transcript = get_transcript(base_params)
      @para_base = base_transcript.file_part(@config.confighash, params[:itemid]).transform_plain_text.text.gsub(/\s+/, ' ')
    end
    if params[:comp].nil? or params[:comp] == ""
      @comp_text_name = nil
      @para_comp = nil
    else
      @comp_text_name = params[:comp]
      comp_params = {itemid: params[:itemid], msslug: params[:comp]}
      comp_transcript = get_transcript(comp_params)
      #gsum is added to remove extra spaces; ideally this would happen at XSLT level
      @para_comp = comp_transcript.file_part(@config.confighash, params[:itemid]).transform_plain_text.text.gsub(/\s+/, ' ')
    end

    render :layout => false

  end
  def variants
    #@expression = get_expression(params[:itemid])
    #check_permission(expression); return if performed?
    #check_transcript_existence(item, params); return if performed?
    transcript = get_transcript(params)
    
    ## TODO: this call is not ideal
    ## but calling file it, bubbles ups to the item level expression no matter 
    ## what structure level expression has been called. 
    ## this is required at the moment since the xslt sheet is designed for this
    ## But when each transcription can point to its own tei file, 
    ## the xslt may need to be written
    file = transcript.file(@config.confighash)

    xslt_param_array = ["pid", "'#{params[:itemid]}'"]
    @para_variants = file.transform("#{Rails.root}/xslt/default/critical/para_variants.xsl", xslt_param_array)
    
    render :layout => false
  end
  def notes
    #item = get_item(params)
    #check_permission(item); return if performed?
    #check_transcript_existence(item, params); return if performed?
    transcript = get_transcript(params)
    # same message as above
    file = transcript.file(@config.confighash)

    xslt_param_array = ["pid", "'#{params[:itemid]}'"]
    @para_notes = file.transform("#{Rails.root}/xslt/default/critical/para_notes.xsl", xslt_param_array)
    render :layout => false
  end
end
