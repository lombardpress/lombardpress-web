class LbpConfig 
	attr_reader :logo, 
	:title, 
	:bannermessage, 
	:biography, 
	:bibliography, 
	:timeline, 
	:about,
	:blog,
	:default_ms_image,
	:dark_color,
	:light_color,
	:article_config_hash,
	:commentaryid,
	:confighash


	def initialize url
		if url.include? "localhost:3000" or url.include? "plaoulcommentary" or url.include? "petrusplaoul"
			self.set_plaoul_config
		elsif url.include? "localhost:3001" or url.include? "wodehamordinatio" or url.include? "adamwodeham"
			self.set_wodeham_config
		elsif url.include? "localhost:3002" or url.include? "graciliscommentary"
			self.set_gracilis_config
		elsif url.include? "localhost:3003" or url.include? "anconacommentary"
			self.set_ancona_config
		else
			self.set_plaoul_config
		end
	end


	def set_plaoul_config

		@logo = "Petrus Plaoul"
		@title = "The Commentary on the Sentences of Peter Plaoul"
		@bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
		@biography = true
		@bibliography = true
		@timeline = true
		@about = true
		@blog = false
		@default_ms_image = "'reims'" #single quotes are required here in order to pass a string as parameter into Nokogir
		@dark_color = "#BBCEBE"
		@light_color = "#E6EDE8"

		@article_config_hash = {
		biography: 
			{xml: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulBiography.xml",
			 xslt: "#{Rails.root}/xslt/articles/biography.xsl"
			},
		timeline: 
			{xml: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulTimeLineTEI.xml", 
			 xslt: "#{Rails.root}/xslt/articles/timeline.xsl"
			 },
		bibliography: 
			{xml: "https://bitbucket.org/jeffreycwitt/bibliography/raw/master/bibliography.xml", 
			 xslt: "#{Rails.root}/xslt/articles/bibliography.xsl"
			},
		about: 	
			{xml: "https://bitbucket.org/jeffreycwitt/pp-about/raw/master/pp-about.xml", 
			 xslt: "#{Rails.root}/xslt/articles/standard.xsl"
			}
		}

		

		commentaryid = "plaoulcommentary"
		@commentaryid = commentaryid
		commentarydirname = 'pp-projectfiles'
		@confighash = self.set_confighash(commentarydirname)

	end
	def set_gracilis_config

		@logo = "Petrus Gracilis"
		@title = "The Commentary on the Sentences of Peter Gracilis"
		@bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
		@biography = false
		@bibliography = true
		@timeline = false
		@about = true
		@blog = false
		@default_ms_image = "'lon'" #single quotes are required here in order to pass a string as parameter into Nokogir
		@dark_color = "#F2D5D9"
		@light_color = "#F9EFF1"

		@article_config_hash = {
			biography: 
				{xml: "https://bitbucket.org/jeffreycwitt/pg-biography/raw/master/pg-biography.xml",
				 xslt: "#{Rails.root}/xslt/articles/biography.xsl"
				},
			bibliography: 
				{xml: "https://bitbucket.org/jeffreycwitt/pg-bibliography/raw/master/pg-bibliography.xml", 
				 xslt: "#{Rails.root}/xslt/articles/bibliography.xsl"
				},
			about: 	
				{xml: "https://bitbucket.org/jeffreycwitt/pg-about/raw/master/pg-about.xml", 
				 xslt: "#{Rails.root}/xslt/articles/standard.xsl"
				}
			}

		
		commentaryid = "graciliscommentary"
		@commentaryid = commentaryid
		commentarydirname = 'pg-projectfiles'
		@confighash = self.set_confighash(commentarydirname)
	end
	def set_wodeham_config

		@logo = "Adam Wodeham"
		@title = "The Ordinatio Commentary on the Sentences of Adam Wodeham"
		@bannermessage = "A working edition of Adam Wodeham's Ordinatio Commentary on the Sentences of Peter Lombard"
		@biography = true
		@bibliography = true
		@timeline = false
		@about = true
		@blog = false
		@default_ms_image = "'sorb'" #single quotes are required here in order to pass a string as parameter into Nokogir
		@dark_color = "#bbbbce"
		@light_color = "#e6e6ed"

		@article_config_hash = {
			biography: 
				{xml: "https://bitbucket.org/jeffreycwitt/aw-biography/raw/master/aw-biography.xml",
				 xslt: "#{Rails.root}/xslt/articles/biography.xsl"
				},
			bibliography: 
				{xml: "https://bitbucket.org/jeffreycwitt/aw-bibliography/raw/master/aw-bibliography.xml", 
				 xslt: "#{Rails.root}/xslt/articles/bibliography.xsl"
				},
			about: 	
				{xml: "https://bitbucket.org/jeffreycwitt/aw-about/raw/master/aw-about.xml", 
				 xslt: "#{Rails.root}/xslt/articles/standard.xsl"
				}
			}


		commentaryid = "wodehamordinatio"
		@commentaryid = commentaryid
		commentarydirname = 'aw-projectfiles'
		@confighash = self.set_confighash(commentarydirname)
	end

	def set_ancona_config

		@logo = "Augustinus de Ancona"
		@title = "The Commentary on the Sentences of Augustinus de Ancona"
		@bannermessage = "A working edition of Augustinus de Ancona's Commentary on the Sentences of Peter Lombard"
		@biography = false
		@bibliography = false
		@timeline = false
		@about = false
		@blog = false
		@default_ms_image = "'troyes'" #single quotes are required here in order to pass a string as parameter into Nokogir
		@dark_color = "#bbbbce"
		@light_color = "#e6e6ed"

		@article_config_hash = {
			about: 	
				{xml: "https://bitbucket.org/jeffreycwitt/aw-about/raw/master/aw-about.xml", 
				 xslt: "#{Rails.root}/xslt/articles/standard.xsl"
				}
			}


		commentaryid = "anconacommentary"
		@commentaryid = commentaryid
		commentarydirname = 'ada-projectfiles'
		@confighash = self.set_confighash(commentarydirname)
	end

	def set_confighash(projectfiledir)
			confighash = {
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
	return confighash
	end
end
