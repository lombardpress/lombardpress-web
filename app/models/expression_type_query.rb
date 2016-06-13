class ExpressionTypeQuery < Lbp::Query
	## All this query files should re organized in
	# and ideally included in lbp.rb or factored 
	# into the development of a static api
	

	def initialize()
		
	end
	# the term expression refers to all expressions 
	# contained by the works within this work group
	# the current database does not yet use this 
	# terminology, but sufficiently approximates it
	
	def expression_list(expression_type_id)
		query = "
			SELECT ?expression_type_title ?expression ?expressiontitle ?author ?authorTitle ?item ?itemTitle ?questionTitle ?itemOrder
	      {
	        <http://scta.info/resource/#{expression_type_id}> <http://purl.org/dc/elements/1.1/title> ?expression_type_title . 
	        ?expression <http://scta.info/property/expressionType> <http://scta.info/resource/#{expression_type_id}> .
	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
	        
	        ?expression <http://scta.info/property/hasStructureItem> ?item .
	        ?item <http://purl.org/dc/elements/1.1/title> ?itemTitle  . 
	        ?item <http://scta.info/property/totalOrderNumber> ?itemOrder .
	        OPTIONAL
	      	{
	      	?item <http://scta.info/property/questionTitle> ?questionTitle  .
	      	}
	      	OPTIONAL{
	      	?expression <http://www.loc.gov/loc.terms/relators/AUT> ?author	.
	        ?author <http://purl.org/dc/elements/1.1/title> ?authorTitle .
	      	}
	      }
	       
	      ORDER BY ?authorTitle ?itemOrder
	      
	      "

		result = self.query(query)
	end
end