class WorkGroupQuery < Lbp::Query
	## All this query files should re organized in
	# and ideally included in lbp.rb or factored 
	# into the development of a static api
	

	def initialize()
		
	end
	# the term expression refers to all expressions 
	# contained by the works within this work group
	# the current database does not yet use this 
	# terminology, but sufficiently approximates it

	def expression_list(workgroup_short_id)
		query = "
			SELECT ?workgrouptitle ?expression ?expressiontitle
	      {
	        <http://scta.info/resource/#{workgroup_short_id}> <http://purl.org/dc/elements/1.1/title> ?workgrouptitle .
	        <http://scta.info/resource/#{workgroup_short_id}> <http://purl.org/dc/terms/hasPart> ?expression .
	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
	      }
	      ORDER BY ?expressiontitle
	      "

		result = self.query(query)
	end
end
 