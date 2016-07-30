class ParagraphexemplarController < ApplicationController
    include TextMethods
	def json

    # para variable here is simpy the expressionObj
    para = get_expression(params)
    number = para.order_number
    
		expression_hash = {
        #:pid => pid,
        :itemid => params[:itemid],     
        :next => if para.next != nil then para.next.to_s.split("/").last else nil end, 
        :previous => if para.previous != nil then para.previous.to_s.split("/").last else nil end,
        :number => number,
        :transcriptions => para.manifestations.map {|m| m.to_s},
        :abbreviates => para.abbreviates.map {|item| item.to_s},
        :abbreviatedBy => para.abbreviatedBy.map {|item| item.to_s},
        :references => para.references.map {|item| item.to_s},
        :referencedBy => para.referencedBy.map {|item| item.to_s},
        :copies => para.copies.map {|item| item.to_s},
        :copiedBy => para.copiedBy.map {|item| item.to_s},
        :quotes => para.quotes.map {|item| item.to_s},
        :quotedBy => para.quotedBy.map {|item| item.to_s},
        :mentions => para.mentions.map {|item| item.to_s},
        #:wordcount => paratranscript.word_count,
        #:wordfrequency => paratranscript.word_frequency

      }
      
    render :json => expression_hash
  end
  
end