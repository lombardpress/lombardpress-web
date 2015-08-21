class ParagraphexemplarController < ApplicationController
	def json
		commentaryid = @config.commentaryid
		#itemid = "wdr-l1prol"
		itemid = params[:itemid]
		#pid = "wdrl1prol-qutvrs"
		pid = params[:pid]
		
		para = Lbp::ParagraphExemplar.new(@config.confighash, "http://scta.info/text/#{commentaryid}/paragraph/#{pid}")

		
		paragraph_hash = {
        :next => if para.next != nil then para.next.split("/").last else nil end, 
        :previous => if para.previous != nil then para.previous.split("/").last else nil end,
        :number => para.paragraph_number,
        :transcriptions => para.transcriptions.map {|item| item[:o].to_s},
        :abbreviates => para.abbreviates.map {|item| item[:o].to_s},
        :abbreviatedBy => para.abbreviatedBy.map {|item| item[:o].to_s},
        :references => para.references.map {|item| item[:o].to_s},
        :copies => para.copies.map {|item| item[:o].to_s},
        :quotes => para.quotes.map {|item| item[:o].to_s},
        :mentions => para.mentions.map {|item| item[:o].to_s},

      }
			
    
    render :json => paragraph_hash
  end
  
end