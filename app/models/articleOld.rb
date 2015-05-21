=begin
class Article
	attr_reader :config
	def initialize(config)
		@config = config
	end
	def xml_file(key)
		@config.article_config_hash[key][:xml]
	end
	def xslt_file(key)
		@config.article_config_hash[key][:xslt]
	end
	
end
=end