class Setting < ActiveRecord::Base
	attr_reader :confighash
  has_many :articles, dependent: :destroy
  after_initialize :set_confighash


  private
	  def set_confighash()
	  	# can't figure out how to get self.projectfildir
	  	# but its not causing an error because a lot of stuff in the config hash is not actually needed
	  	projectfiledir = "test"
				@confighash = {
					local_texts_dir: "#{Rails.root}/projectfiles/#{projectfiledir}/textfiles/", 
						citation_lists_dir: "#{Rails.root}/projectfiles/#{projectfiledir}/citationlists/", 
						xslt_dirs: { "default" => {
							critical: "#{Rails.root}/xslt/default/critical/",
							documentary: "#{Rails.root}/xslt/default/documentary/", 
							main_view: "main_view.xsl",
							index_view: "text_display_index.xsl", 
							clean_view: "clean_view.xsl",
							plain_text: "plaintext.xsl",
							json: "LbpToJson.xsl", 
							toc: "toc.xsl"
							}
						},
					git_repo: "bitbucket.org/jeffreycwitt/",
					git_username: ENV["GUN"],
					git_password: ENV["GPW"]
				}
	end
end
