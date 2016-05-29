module IndexMethods
  extend ActiveSupport::Concern
		
	def filter_index_query(raw_results)
		@results = []	
		previousname = raw_results[0][:resourceTitle]

		@raw_results.each do |result| 
			if result[:resourceTitle] != "" && result[:resourceTitle] != previousname
				@results.push(result)
			end
			previousname = result[:resourceTitle]
		end
		return @results
	end
end

