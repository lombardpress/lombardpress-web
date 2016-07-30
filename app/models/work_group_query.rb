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
	def work_group_list(workgroup_short_id)
		query = "
			SELECT ?workgrouptitle ?sub_workgroup ?sub_workgroup_title ?sub_workgroup_desc
	      {
	        <http://scta.info/resource/#{workgroup_short_id}> <http://purl.org/dc/elements/1.1/title> ?workgrouptitle .
	        <http://scta.info/resource/#{workgroup_short_id}> <http://scta.info/property/hasWorkGroup> ?sub_workgroup .
	        ?sub_workgroup <http://purl.org/dc/elements/1.1/title> ?sub_workgroup_title .
	        ?sub_workgroup <http://purl.org/dc/elements/1.1/description> ?sub_workgroup_desc .
	      }
	      ORDER BY ?sub_workgroup_title
	      "

		result = self.query(query)
	end
	def expression_list(workgroup_short_id)
		query = "
			SELECT ?title ?expression ?expressiontitle ?author ?authorTitle
	      {
	        <http://scta.info/resource/#{workgroup_short_id}> <http://purl.org/dc/elements/1.1/title> ?title .
	        <http://scta.info/resource/#{workgroup_short_id}> <http://purl.org/dc/terms/hasPart> ?expression .
	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
	        ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
	        ?expression <http://www.loc.gov/loc.terms/relators/AUT> ?author	.
	        ?author <http://purl.org/dc/elements/1.1/title> ?authorTitle .
	      }
	      ORDER BY ?authorTitle
	      "

		result = self.query(query)
	end
end
 