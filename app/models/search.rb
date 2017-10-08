class Search < Lbp::Query
	def questions(expressionid: nil, authorid: nil, workGroupId: nil, expressiontypeid: nil, searchterm: "")
    expressionidSparql = ''
    if expressionid
			# QUERY BEFORE isMemberOf Property

			# expressionidSparql = "
      # {
      #   {
      #     ?resource <http://scta.info/property/isPartOfStructureItem> ?structureItem .
      #     <#{expressionid}> <http://scta.info/property/hasStructureItem> ?structureItem .
      #   }
      # UNION
      #   {
      #     <#{expressionid}> <http://scta.info/property/hasStructureItem> ?resource .
      #   }
      # }
      # "

			#QUERY AFTER isMemberOf Property
			expressionidSparql = "?resource <http://scta.info/property/isMemberOf> <#{expressionid}> ."
    end
    authoridSparql = ''
    if authorid
      authoridSparql = "
      ?resource <http://scta.info/property/isPartOfTopLevelExpression> ?toplevel  .
      ?toplevel <http://www.loc.gov/loc.terms/relators/AUT> <#{authorid}>	.
      "
    end
    workGroupSparql = ''
    if workGroupId
      workGroupSparql = "
      ?resource <http://scta.info/property/isPartOfTopLevelExpression> ?toplevel  .
      <#{workGroupId}> <http://scta.info/property/hasExpression> ?toplevel	.
      "
    end

    expressionTypeSparql = ''
    if expressiontypeid
			# query before isMemberOf property
			## this expression type is only going to get question titles of items belonging to higher level collections

      # expressionTypeSparql = "
      # ?expression <http://scta.info/property/expressionType> <#{expressiontypeid}>  .
      # ?expression <http://scta.info/property/hasStructureItem> ?resource	.
      # "

			expressionTypeSparql = "
			\n #check for all resources that are a member of the expression type \n
      {
				?expression <http://scta.info/property/expressionType> <#{expressiontypeid}>  .
      	?resource <http://scta.info/property/isMemberOf> ?expression	.
			}
			UNION
			\n #check for all resources have this expression type \n
			{
				?resource <http://scta.info/property/expressionType> <#{expressiontypeid}>  .
      }
      "
    end
		query = "#{@prefixes}
      SELECT ?resource ?resource_short_id ?resource_title ?resource_status ?qtitle ?author_title ?author_short_id ?toplevel_expression ?toplevel_expression_title ?toplevel_expression_short_id ?structure_type ?parent_item ?parent_item_title ?parent_item_short_id ?parent_item_author ?parent_item_author_title ?parent_item_author_short_id ?parent_item_status
      {
        ?resource <http://scta.info/property/questionTitle> ?qtitle  .
        #{expressionidSparql}
        #{authoridSparql}
        #{workGroupSparql}
        #{expressionTypeSparql}
        FILTER (REGEX(STR(?qtitle), '#{searchterm}', 'i')) .
        ?resource <http://purl.org/dc/elements/1.1/title> ?resource_title .
        ?resource <http://scta.info/property/structureType> ?structure_type .
        OPTIONAL
        {
          ?resource <http://scta.info/property/shortId> ?resource_short_id	.
        }
        OPTIONAL
        {
          ?resource <http://www.loc.gov/loc.terms/relators/AUT> ?author	.
          ?author <http://purl.org/dc/elements/1.1/title> ?author_title .
          ?author <http://scta.info/property/shortId> ?author_short_id .
        }
        OPTIONAL
        {
          ?resource <http://scta.info/property/status> ?resource_status	.
        }
        OPTIONAL
        {
          ?resource <http://scta.info/property/isPartOfTopLevelExpression> ?toplevel_expression	.
          ?toplevel_expression <http://purl.org/dc/elements/1.1/title> ?toplevel_expression_title .
          ?toplevel_expression <http://scta.info/property/shortId> ?toplevel_expression_short_id .
        }
        OPTIONAL
        {
          ?resource <http://scta.info/property/isPartOfStructureItem> ?parent_item	.
          ?parent_item <http://purl.org/dc/elements/1.1/title> ?parent_item_title .
          ?parent_item <http://scta.info/property/shortId> ?parent_item_short_id .
          ?parent_item <http://scta.info/property/status> ?parent_item_status .
          ?parent_item <http://www.loc.gov/loc.terms/relators/AUT> ?parent_item_author .
          ?parent_item_author <http://purl.org/dc/elements/1.1/title> ?parent_item_author_title .
          ?parent_item_author <http://scta.info/property/shortId> ?parent_item_author_short_id .
        }

      }
      ORDER BY ?resource
    "
    result = self.query(query)
    return result

	end
end
