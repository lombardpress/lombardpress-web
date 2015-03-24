class Article
	def xml_file(key)
		Rails.configuration.article_config_hash[key][:xml]
	end
	def xslt_file(key)
		Rails.configuration.article_config_hash[key][:xslt]
	end
	
end
