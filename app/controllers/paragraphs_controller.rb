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
    @expression = Lbp::Expression.new(url)
    
    if @expression.structureType_shortId == "structureItem"
      @target_url = "/text/#{@expression.resource_shortId}" 
    else
      @target_url = "/text/#{@expression.item_level_expression_shortId}##{@expression.resource_shortId}" 
    end
    @target_title = @expression.title
    #itemid = @para.itemid
    #commentaryid = @para.cid
    #pid = @para.pid
    #commentaryurl = "http://scta.info/text/#{commentaryid}/commentary"
    #commentary = Lbp::Collection.new(@config.confighash, commentaryurl)
    #@commentary_title = commentary.title
    #itemurl = "http://scta.info/text/#{commentaryid}/item/#{itemid}"
    #@item = Lbp::Item.new(@config.confighash, itemurl)
    
    #canonicalwit = @item.canonical_transcription_slug
    transcript = get_transcript(params)
    file = transcript.file_part(@config.confighash, @expression.resource_shortId)
    #transcript = @item.transcription(source: "origin", wit: canonicalwit)
    
    @text = file.transform_plain_text
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


  #TODO 
  # this is being used by the get show paragraph image reques 
  def json
    @expression = get_expression(params)
    check_permission(@expression); return if performed?

    # ms_slugs is not great because its hard coding "critical"
    # what if the name of the manifestion for a critical manifestion was not called critical
    # more idea to check database to get a manifestationType
    # but this could be costly. If there were 20 or 30 manifestations 
    # then you'd be making lots of requests to db
    ms_slugs = @expression.manifestationUrls.map {|m| unless m.include? 'critical' then m.split("/").last end}.compact
    transcript = get_transcript(params)

    file = transcript.file_part(@config.confighash, params[:itemid])

    text = file.transform("#{Rails.root}/xslt/default/documentary/documentary_simple.xsl")
    
    #TODO this should be become part of a core method
    number = @expression.order_number

    #TODO: db and lbp.gem should be returning nil, but the actually returning "http://scta.info/resource/" for nil. 
    # Once this is fixed this conditional can be removed
    if @expression.previous != nil && @expression.previous  != "http://scta.info/resource/"
      previous_expression = @expression.previous.split("/").last
    else
      previous_expression = nil
    end
    if @expression.next != nil && @expression.next != "http://scta.info/resource/"
      next_expression = @expression.next.split("/").last
    else
      next_expression = nil
    end
    
    paragraph_hash = {
        :paragraph_text => text.text.to_s.gsub(/\n/, '<br/> *').gsub(/\s+/, ' '),
        :next_para => next_expression,
        :previous_para => previous_expression,
        :paragraph_number => number,
        :ms_slugs => ms_slugs,
        :itemid => params[:itemid],
        
      }

    
    render :json => paragraph_hash
  
  end

  def collation
    
    #item = get_item(params)
    @expression = get_expression(params)
    
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
