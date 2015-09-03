class ParagraphexemplarController < ApplicationController
	def json
		commentaryid = @config.commentaryid
		#itemid = "wdr-l1prol"
		itemid = params[:itemid]
		#pid = "wdrl1prol-qutvrs"
		pid = params[:pid]
		#if paragraphexamplar is really a class for sections of diverse types
        #articles, questions, divisions, etc, then we need to know the type, 
        #since the current url scheme lists the type in the id. 
        #here we have hard-coded paragraph which means this only works for paragraphs
        #params[:type] could fix this with values such as "paragraph", "articulus", "dubium" or generic "division"
		para = Lbp::ParagraphExemplar.new(@config.confighash, "http://scta.info/text/#{commentaryid}/paragraph/#{pid}")
        
#begin test
    
    itemid = para.itemid
    commentaryid = para.cid
    pid = para.pid

    itemurl = "http://scta.info/text/#{commentaryid}/item/#{itemid}"
    item = Lbp::Item.new(@config.confighash, itemurl)

    canonicalwit = item.canonical_transcription_slug

    transcript = item.transcription(source: "origin", wit: canonicalwit)
    paratranscript = transcript.paragraph(pid)
    
#end test
		
		paragraph_hash = {
        :pid => pid,
        :itemid => itemid,     
        :next => if para.next != nil then para.next.split("/").last else nil end, 
        :previous => if para.previous != nil then para.previous.split("/").last else nil end,
        :number => para.paragraph_number,
        :transcriptions => para.transcriptions.map {|item| item[:o].to_s},
        :abbreviates => para.abbreviates.map {|item| item[:o].to_s},
        :abbreviatedBy => para.abbreviatedBy.map {|item| item[:o].to_s},
        :references => para.references.map {|item| item[:o].to_s},
        :referencedBy => para.referencedBy.map {|item| item[:o].to_s},
        :copies => para.copies.map {|item| item[:o].to_s},
        :copiedBy => para.copiedBy.map {|item| item[:o].to_s},
        :quotes => para.quotes.map {|item| item[:o].to_s},
        :mentions => para.mentions.map {|item| item[:o].to_s},
        :wordcount => paratranscript.word_count,
        :wordfrequency => paratranscript.word_frequency

      }

			
    
    render :json => paragraph_hash
  end
  
end