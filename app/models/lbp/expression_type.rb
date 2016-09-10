module Lbp
	class ExpressionType
		def structure_items_by_expression_display
      query = "
  			SELECT ?expression_type_title ?expression ?expressiontitle ?author ?authorTitle ?item ?itemTitle ?questionTitle ?itemOrder
  	      {
  	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?expression_type_title .
  	        ?expression <http://scta.info/property/expressionType> <http://scta.info/resource/#{short_id}> .
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
          results = Query.new.query(query)
		end
		def info_display
			query = "
			SELECT ?description ?isPartOf ?hasPart ?next ?previous
	      {
	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/description> ?description .
					OPTIONAL {
	          <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/hasPart> ?hasPart .
	        }
	        OPTIONAL {
	          <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/isPartOf> ?isPartOf .
	        }
	        OPTIONAL {
	          <http://scta.info/resource/#{short_id}> <http://scta.info/property/next> ?next .
	        }
	        OPTIONAL {
	          <http://scta.info/resource/#{short_id}> <http://scta.info/property/previous> ?previous .
	        }
	      }"
        results = Query.new.query(query)
		end
  end
end
