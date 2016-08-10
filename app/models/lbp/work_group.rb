module Lbp
	class WorkGroup
    def expressions_display
      query = "
  			SELECT ?title ?expression ?expressiontitle ?author ?authorTitle
  	      {
  	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?title .
  	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/hasPart> ?expression .
  	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
  	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .

  	    	  OPTIONAL
  	      	{
  	      		?expression <http://www.loc.gov/loc.terms/relators/AUT> ?author	.
  	        	?author <http://purl.org/dc/elements/1.1/title> ?authorTitle .
  	      	}
  	    	}
  	      ORDER BY ?authorTitle
  	      "

  		results = Query.new.query(query)
    end
    def parts_display
      # TODO: note that the eventually the db should be changed here and hasWorkGroup should be changed to hasPart
      # a workGroup should always list its immediate children (as parts) and all descendant expressions as "hasExpression"
      query = "
  			SELECT ?workgrouptitle ?sub_workgroup ?sub_workgroup_title ?sub_workgroup_desc
  	      {
  	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?workgrouptitle .
  	        <http://scta.info/resource/#{short_id}> <http://scta.info/property/hasWorkGroup> ?sub_workgroup .
  	        ?sub_workgroup <http://purl.org/dc/elements/1.1/title> ?sub_workgroup_title .
  	        ?sub_workgroup <http://purl.org/dc/elements/1.1/description> ?sub_workgroup_desc .
  	      }
  	      ORDER BY ?sub_workgroup_title
  	      "

      results = Query.new.query(query)
    end
  end
end
