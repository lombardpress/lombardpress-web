class MiscQuery < Lbp::Query
	def zone_info(manifestationurl)
		nameurl = "<#{nameurl}>"
		query = "#{@prefixes}
			SELECT DISTINCT ?zone ?ulx ?uly ?lry ?lrx ?position ?height ?width ?canvasurl ?imageurl ?totalHeight ?totalWidth
      {
        <#{manifestationurl}> <http://scta.info/property/isOnZone> ?zone .
         ?zone <http://scta.info/property/ulx> ?ulx .
         ?zone <http://scta.info/property/uly> ?uly .
         ?zone <http://scta.info/property/lry> ?lry .
         ?zone <http://scta.info/property/lrx> ?lrx .
         ?zone <http://scta.info/property/position> ?position .
         ?zone <http://scta.info/property/height> ?height .
         ?zone <http://scta.info/property/width> ?width .
         ?zone <http://scta.info/property/isPartOfSurface> ?surface .
				 ?surface <http://scta.info/property/hasISurface> ?isurface .
				 ?isurface <http://scta.info/property/hasCanvas> ?canvasurl .
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
	 #replaces folio_info
	 def folio_info2(surfaceid)
      query = "#{@prefixes}
         SELECT DISTINCT ?surfaceTitle ?zone ?ulx ?uly ?lry ?lrx ?position ?c_height ?c_width ?isurface ?isurfaceTitle ?icodexTitle ?canvasurl ?imageurl ?next_surface ?previous_surface
      {
				<#{surfaceid}> <http://purl.org/dc/elements/1.1/title> ?surfaceTitle .
				<#{surfaceid}> <http://scta.info/property/hasISurface> ?isurface .
				OPTIONAL{
					<#{surfaceid}> <http://scta.info/property/next> ?next_surface .
				}
				OPTIONAL{
					<#{surfaceid}> <http://scta.info/property/previous> ?previous_surface .
				}
				OPTIONAL{
					?isurface <http://purl.org/dc/elements/1.1/title> ?isurfaceTitle .
					?isurface <http://purl.org/dc/elements/1.1/isPartOf> ?icodex .
					?icodex <http://purl.org/dc/elements/1.1/title> ?icodexTitle
				}
				?isurface <http://scta.info/property/hasCanvas> ?canvas .
				OPTIONAL{
					?canvas <http://iiif.io/api/presentation/2#hasImageAnnotations> ?blank .
				}
				OPTIONAL{
					?canvas <http://www.shared-canvas.org/ns/hasImageAnnotations> ?blank .
				}
				 ?canvas <http://www.w3.org/2003/12/exif/ns#width> ?c_width .
				 ?canvas <http://www.w3.org/2003/12/exif/ns#height> ?c_height .
		     ?blank <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> ?o .
		     ?o <http://www.w3.org/ns/oa#hasBody> ?o2 .
		    OPTIONAL{
					 ?o2 <http://rdfs.org/sioc/services#has_service> ?imageurl .
				 }
				 OPTIONAL{
					 ?o2 <http://www.shared-canvas.org/ns/hasRelatedService> ?imageurl .
				 }
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
	 def author_article_list(author_short_id)
      query = "
         SELECT ?article ?articletitle ?article_short_id
         {
           ?article a <http://scta.info/resource/article> .
					 ?article <http://scta.info/property/isArticleOf> <http://scta.info/resource/#{author_short_id}> .
           ?article <http://purl.org/dc/elements/1.1/title> ?articletitle .
					 ?article <http://scta.info/property/shortId> ?article_short_id .
				}
				ORDER BY ?articletitle
				"

      result = self.query(query)
	 end
	 def author_members_article_list(author_short_id)
      query = "
         SELECT DISTINCT ?article ?articletitle ?article_short_id
         {
           ?article a <http://scta.info/resource/article> .
					 ?article <http://scta.info/property/isArticleOf> ?resource .
					 ?resource <http://www.loc.gov/loc.terms/relators/AUT> <http://scta.info/resource/#{author_short_id}> .
           ?article <http://purl.org/dc/elements/1.1/title> ?articletitle .
					 ?article <http://scta.info/property/shortId> ?article_short_id .
				}
				ORDER BY ?articletitle
				"

      result = self.query(query)
	 end
   def expression_query
   query = "#{@prefixes}

        SELECT ?collectiontitle ?title ?item ?questiontitle ?order ?status ?gitRepository
        {
          #{collection_url} <http://scta.info/property/hasStructureItem> ?item .
          #{collection_url} <http://purl.org/dc/elements/1.1/title> ?collectiontitle .
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

        result = self.query(query)
    end
    def expression_type_info(expression_type_id)
      query = "SELECT ?description ?isPartOf ?hasPart ?next ?previous
      {
        <http://scta.info/resource/#{expression_type_id}> <http://purl.org/dc/elements/1.1/description> ?description .

        OPTIONAL {
          <http://scta.info/resource/#{expression_type_id}> <http://purl.org/dc/terms/hasPart> ?hasPart .
        }
        OPTIONAL {
          <http://scta.info/resource/#{expression_type_id}> <http://purl.org/dc/terms/isPartOf> ?isPartOf .
        }
        OPTIONAL {
          <http://scta.info/resource/#{expression_type_id}> <http://scta.info/property/next> ?next .
        }
        OPTIONAL {
          <http://scta.info/resource/#{expression_type_id}> <http://scta.info/property/previous> ?previous .
        }
      }"
      result = self.query(query)
   end
	 def version_history_info(transcription_rdf_id)
	 	query = "
	 		SELECT ?version ?version_shortId ?order_number ?version_label
	     {
				 {
	         <#{transcription_rdf_id}> <http://scta.info/property/hasAncestor> ?version .
					 ?version <http://scta.info/property/shortId> ?version_shortId .
	         ?version <http://scta.info/property/versionOrderNumber> ?order_number .
					 ?version <http://scta.info/property/versionLabel> ?version_label .
	       }
	       UNION
	       {
	         <#{transcription_rdf_id}> <http://scta.info/property/hasDescendant> ?version .
					 ?version <http://scta.info/property/shortId> ?version_shortId .
	         ?version <http://scta.info/property/versionOrderNumber> ?order_number .
					 ?version <http://scta.info/property/versionLabel> ?version_label .
	       }
	     }
	     ORDER BY DESC(?order_number)"
	 		results = self.query(query)
		end
		def codex_display_list(id)
 	 		query = "
 	 		SELECT DISTINCT ?expression ?codex_title ?item_expression_title ?item_expression_question_title ?surface ?surface_title ?surface_order ?manifestation ?manifestation_short_id ?status
 	     {
 	         <#{id}> <http://purl.org/dc/elements/1.1/title> ?codex_title .
					 OPTIONAL{
					 ?icodex <http://scta.info/property/isCodexItemOf> <#{id}> .
					 ?isurface <http://purl.org/dc/elements/1.1/isPartOf> ?icodex .
					 ?surface <http://scta.info/property/hasISurface> ?isurface .
					 ?surface <http://scta.info/property/order> ?surface_order .
					 ?surface <http://purl.org/dc/elements/1.1/title> ?surface_title .
					 ?manifestation <http://scta.info/property/isOnSurface> ?surface .
					 ?manifestation <http://scta.info/property/structureType> <http://scta.info/resource/structureItem> .
					 ?manifestation <http://scta.info/property/shortId> ?manifestation_short_id .
					 ?manifestation <http://scta.info/property/isManifestationOf> ?expression .
					 ?expression <http://purl.org/dc/elements/1.1/title> ?item_expression_title .
					 ?expression <http://scta.info/property/status> ?status .
					 	OPTIONAL {
						 	?expression <http://scta.info/property/questionTitle> ?item_expression_question_title .
					 	}
				 	}
				 }
 	     ORDER BY ?surface_order"
 	 		results = self.query(query)
 		end
		def all_codex_display_list
			query = "
 	 		SELECT ?codex ?codex_title
 	     {
				 ?codex a <http://scta.info/resource/codex> .
				 ?codex <http://purl.org/dc/elements/1.1/title> ?codex_title
				}
			 ORDER BY ?codex_title"
 	    results = self.query(query)

		end




end
