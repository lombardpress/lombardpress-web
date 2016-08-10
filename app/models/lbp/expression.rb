module Lbp
	class Expression
		def structure_items_display
			#url =  "<http://scta.info/resource/#{short_id}>"
			#Lbp::Query.new().collection_query(url)
			query = "
				SELECT ?collectiontitle ?title ?item ?questiontitle ?order ?status ?gitRepository
	      {
	        <http://scta.info/resource/#{short_id}> <http://scta.info/property/hasStructureItem> ?item .
	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?collectiontitle .
	        ?item <http://purl.org/dc/elements/1.1/title> ?title  .
	        ?item <http://scta.info/property/totalOrderNumber> ?order .
	        ?item <http://scta.info/property/status> ?status .
	        ?item <http://scta.info/property/gitRepository> ?gitRepository .
					OPTIONAL
	      	{
	      	?item <http://scta.info/property/questionTitle> ?questiontitle  .
	      	}
	      }
	      ORDER BY ?order"
				results = Query.new.query(query)
		end
		def info_display
			query = "SELECT ?description ?isPartOf ?hasPart ?sponsor ?sponsorTitle ?sponsorLogo ?sponsorLink ?article ?articleTitle
      {
         <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/description> ?description .

         <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/isPartOf> ?isPartOf .
         OPTIONAL {
           <http://scta.info/resource/#{short_id}> <http://scta.info/property/hasSponsor> ?sponsor .
           ?sponsor <http://purl.org/dc/elements/1.1/title> ?sponsorTitle .
           ?sponsor <http://scta.info/property/link> ?sponsorLink .
           ?sponsor <http://scta.info/property/logo> ?sponsorLogo .
         }
         OPTIONAL {
          ?article <http://scta.info/property/isArticleOf> <http://scta.info/resource/#{short_id}> .
          ?article <http://purl.org/dc/elements/1.1/title> ?articleTitle .
         }
         OPTIONAL {
          <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/hasPart> ?hasPart .
         }
      }"
      results = Query.new.query(query)
		end
		def sponsors_display(info)
			sponsors = info.map {|r| {sponsor: r[:sponsor], sponsorTitle: r[:sponsorTitle], sponsorLogo: r[:sponsorLogo], sponsorLink: r[:sponsorLink]}}
			sponsors.uniq!
			# check to see if sponsors array is actaully empty. If it is, set it to empty array
			sponsors = sponsors[0][:sponsor] == nil ? [] : sponsors
		end
		def articles_display(info)
			articles = info.map {|r| {article: r[:article], articleTitle: r[:articleTitle]}}
			articles.uniq!
			# check to see if articles array is actaully empty. If it is, set it to empty array
			articles = articles[0][:article] == nil ? [] : articles
		end
	end
end
