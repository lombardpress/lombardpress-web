class MiscQuery < Lbp::Query
	def zone_info(paragraphurl)
		nameurl = "<#{nameurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?zone ?ulx ?uly ?lry ?lrx ?position ?height ?width ?canvasurl
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
      }
      ORDER BY ?position"
		result = self.query(query)
	end

end