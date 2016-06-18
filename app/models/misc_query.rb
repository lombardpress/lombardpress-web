class MiscQuery < Lbp::Query
	def zone_info(transcripturl)
		nameurl = "<#{nameurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?zone ?ulx ?uly ?lry ?lrx ?position ?height ?width ?canvasurl ?imageurl ?totalHeight ?totalWidth
      {
        <#{transcripturl}> <http://scta.info/property/hasZone> ?zone .
         ?zone <http://scta.info/property/ulx> ?ulx .
         ?zone <http://scta.info/property/uly> ?uly .
         ?zone <http://scta.info/property/lry> ?lry .
         ?zone <http://scta.info/property/lrx> ?lrx .
         ?zone <http://scta.info/property/position> ?position .
         ?zone <http://scta.info/property/height> ?height .
         ?zone <http://scta.info/property/width> ?width .
         ?zone <http://scta.info/property/isZoneOn> ?canvasurl .
         ?canvasurl <http://www.w3.org/2003/12/exif/ns#height> ?totalHeight .
         ?canvasurl <http://www.w3.org/2003/12/exif/ns#width> ?totalWidth .
         ?canvasurl <http://iiif.io/api/presentation/2#hasImageAnnotations> ?blank . 

         ?blank <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> ?o . 
         ?o <http://www.w3.org/ns/oa#hasBody> ?o2 . 
         ?o2 <http://rdfs.org/sioc/services#has_service> ?imageurl .
      }
      ORDER BY ?position"
		result = self.query(query)
	end
   def folio_info(canvasid)
      query = "#{@prefixes}
         SELECT DISTINCT ?zone ?ulx ?uly ?lry ?lrx ?position ?height ?width ?canvasurl ?imageurl
      {
        <#{canvasid}> <http://iiif.io/api/presentation/2#hasImageAnnotations> ?blank . 
         ?blank <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> ?o . 
         ?o <http://www.w3.org/ns/oa#hasBody> ?o2 . 
         ?o2 <http://rdfs.org/sioc/services#has_service> ?imageurl .
      }"
      result = self.query(query)
   end
   def expression_info(expressionid)
      query = "SELECT ?description ?isPartOf ?hasPart ?sponsor ?sponsorTitle ?sponsorLogo ?sponsorLink ?article ?articleTitle
      {
         <http://scta.info/resource/#{expressionid}> <http://purl.org/dc/elements/1.1/description> ?description . 
         
         <http://scta.info/resource/#{expressionid}> <http://purl.org/dc/terms/isPartOf> ?isPartOf . 
         OPTIONAL {
           <http://scta.info/resource/#{expressionid}> <http://scta.info/property/hasSponsor> ?sponsor .
           ?sponsor <http://purl.org/dc/elements/1.1/title> ?sponsorTitle . 
           ?sponsor <http://scta.info/property/link> ?sponsorLink . 
           ?sponsor <http://scta.info/property/logo> ?sponsorLogo .
         }
         OPTIONAL {
          ?article <http://scta.info/property/isArticleOf> <http://scta.info/resource/#{expressionid}> .
          ?article <http://purl.org/dc/elements/1.1/title> ?articleTitle .
         }
         OPTIONAL {
          <http://scta.info/resource/#{expressionid}> <http://purl.org/dc/terms/hasPart> ?hasPart . 
         }
      }"
      result = self.query(query)
   end

   def author_expression_list(author_short_id)
      query = "
         SELECT ?title ?expression ?expressiontitle
         {
           <http://scta.info/resource/#{author_short_id}> <http://purl.org/dc/elements/1.1/title> ?title .
           ?expression <http://www.loc.gov/loc.terms/relators/AUT> <http://scta.info/resource/#{author_short_id}> .
           ?expression a <http://scta.info/resource/expression> . 
           ?expression <http://scta.info/property/level> '1' .
           ?expression <http://purl.org/dc/elements/1.1/title> ?expressiontitle  .
         }
         ORDER BY ?expressiontitle
         "

      result = self.query(query)

   end


end

