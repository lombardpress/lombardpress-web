class MiscQuery < Lbp::Query
	def zone_info(paragraphurl)
		nameurl = "<#{nameurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?zone ?ulx ?uly ?lry ?lrx ?position ?height ?width ?canvasurl ?imageurl
      {
        <#{paragraphurl}> <http://scta.info/property/hasZone> ?zone .
         ?zone <http://scta.info/property/ulx> ?ulx .
         ?zone <http://scta.info/property/uly> ?uly .
         ?zone <http://scta.info/property/lry> ?lry .
         ?zone <http://scta.info/property/lrx> ?lrx .
         ?zone <http://scta.info/property/position> ?position .
         ?zone <http://scta.info/property/height> ?height .
         ?zone <http://scta.info/property/width> ?width .
         ?zone <http://scta.info/property/isZoneOn> ?canvasurl .
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


end

