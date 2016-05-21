class IndexQuery < Lbp::Query
	attr_reader :commentaryurl

	def initialize(commentaryurl)
		@commentaryurl = "<#{commentaryurl}>"
	end
	def name_list(type='All')
		if type=='All'
			query = "#{@prefixes}
				SELECT DISTINCT ?name ?nameTitle 
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/mentions> ?name .
	        ?name a <http://scta.info/resource/person> .
		      ?name <http://purl.org/dc/elements/1.1/title> ?nameTitle  .
	      }
	      ORDER BY ?nameTitle"
	   else
	   	query = "#{@prefixes}
				SELECT DISTINCT ?name ?nameTitle 
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/mentions> ?name .
	 # difference between personType in predicate and persontype in object is disconcerting -- this possible future break point
	        ?name <http://scta.info/property/personType> <http://scta.info/resource/persontype/#{type}> .
	        ?name a <http://scta.info/resource/person> .
		      ?name <http://purl.org/dc/elements/1.1/title> ?nameTitle  .
	      }
	      ORDER BY ?nameTitle"
	   end   
		result = self.query(query)
	end
	def name_info(nameurl)
		nameurl = "<#{nameurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?nameTitle ?item ?itemTitle ?commentary ?commentaryTitle ?orderNumber
      {
        #{nameurl} <http://purl.org/dc/elements/1.1/title> ?nameTitle  .
        #{nameurl} <http://scta.info/property/mentionedBy> ?item .
        ?item <http://purl.org/dc/elements/1.1/title> ?itemTitle .
         ?item <http://scta.info/property/totalOrderNumber> ?orderNumber .
         ?item <http://scta.info/property/isPartOfCommentary> ?commentary .
         ?item <http://purl.org/dc/elements/1.1/title> ?commentaryTitle
      }
      # ORDER BY ?orderNumber"
		result = self.query(query)
	end
	def title_list(type='All')
		if type=='All'
			query = "#{@prefixes}
				SELECT DISTINCT ?title ?titleTitle 
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/mentions> ?title .
	        ?title a <http://scta.info/resource/work> .
		      ?title <http://purl.org/dc/elements/1.1/title> ?titleTitle  .
	      }
	      ORDER BY ?titleTitle"
	   else
	   	query = "#{@prefixes}
				SELECT DISTINCT ?title ?titleTitle 
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/mentions> ?title .
	 # difference between workType in predicate and worktype in object is disconcerting -- this possible future break point
	        ?title <http://scta.info/property/workType> <http://scta.info/resource/worktype/#{type}> .
	        ?title a <http://scta.info/resource/work> .
		      ?title <http://purl.org/dc/elements/1.1/title> ?titleTitle  .
	      }
	      ORDER BY ?titleTitle"
	   end   
		result = self.query(query)
	end
	def title_info(titleurl)
		titleurl = "<#{titleurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?tileTitle ?item ?itemTitle ?commentary ?commentaryTitle ?orderNumber
      {
        #{titleurl} <http://purl.org/dc/elements/1.1/title> ?titleTitle  .
        #{titleurl} <http://scta.info/property/mentionedBy> ?item .
        ?item <http://purl.org/dc/elements/1.1/title> ?itemTitle .
         ?item <http://scta.info/property/totalOrderNumber> ?orderNumber .
         ?item <http://scta.info/property/isPartOfCommentary> ?commentary .
         ?item <http://purl.org/dc/elements/1.1/title> ?commentaryTitle
      }
      # ORDER BY ?orderNumber"
		result = self.query(query)
	end
	def quote_list(type='All')
		if type=='All'
			query = "#{@prefixes}
				SELECT DISTINCT ?quote ?quoteTitle ?quoteCitation
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/quotes> ?quote .
	        ?quote a <http://scta.info/resource/quotation> .
		      ?quote <http://purl.org/dc/elements/1.1/title> ?quoteTitle  .
		      ?quote <http://scta.info/property/citation> ?quoteCitation  .
	      }
	      ORDER BY ?quoteTitle"
	   else
	   	## this conditional is temporarily necessary because the database expects a lowercase biblical. This needs to be standardized in database
	   	if type == 'Biblical' 
	   		type = 'biblical' 
	   		quotationType = "quoteType"
	   	else 
	   		type = type
	   		quotationType = "quotationType"
	   	end

	   	query = "#{@prefixes}
				SELECT DISTINCT ?quote ?quoteTitle ?quoteCitation
	      {
	        #{@commentaryurl} <http://scta.info/property/hasItem> ?item .
	        ?item <http://scta.info/property/quotes> ?quote .
	   # difference between quotationType in predicate and quoteType in object is disconcerting -- this possible future break point Biblical entries need to be changed to 'quotationType' in object
	        ?quote <http://scta.info/property/quotationType> <http://scta.info/resource/#{quotationType}/#{type}> .
	        ?quote a <http://scta.info/resource/quotation> .
		      ?quote <http://purl.org/dc/elements/1.1/title> ?quoteTitle  .
		      ?quote <http://scta.info/property/citation> ?quoteCitation  .
	      }
	      ORDER BY ?quoteTitle"
	   end   
		result = self.query(query)
	end
	def quote_info(quoteurl)
		quoteurl = "<#{quoteurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?quoteTitle ?item ?itemTitle ?commentary ?commentaryTitle ?orderNumber
      {
        #{quoteurl} <http://purl.org/dc/elements/1.1/title> ?quoteTitle  .
        #{quoteurl} <http://scta.info/property/quotedBy> ?item .
        ?item <http://purl.org/dc/elements/1.1/title> ?itemTitle .
         ?item <http://scta.info/property/totalOrderNumber> ?orderNumber .
         ?item <http://scta.info/property/isPartOfCommentary> ?commentary .
         ?item <http://purl.org/dc/elements/1.1/title> ?commentaryTitle
      }
      # ORDER BY ?orderNumber"
		result = self.query(query)
	end

	def expression_list()
		query = "
			SELECT ?workgrouptitle ?expression ?expressiontitle
	      {
	        <http://scta.info/scta> <http://purl.org/dc/elements/1.1/title> ?workgrouptitle .
	        <http://scta.info/scta> <http://purl.org/dc/terms/hasPart> ?expression .
	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
	      }
	      ORDER BY ?expressiontitle
	      "

		result = self.query(query)
	end
end
 