def set_plaoul_config

	Rails.application.config.logo = "Petrus Plaoul"
	Rails.application.config.title = "The Commentary on the Sentences of Peter Plaoul"
	Rails.application.config.bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
	Rails.application.config.biography = true
	Rails.application.config.bibliography = true
	Rails.application.config.timeline = true
	Rails.application.config.about = true
	Rails.application.config.blog = false
	Rails.application.config.default_ms_image = "'reims'" #single quotes are required here in order to pass a string as parameter into Nokogir
	Rails.application.config.dark_color = "#BBCEBE"
	Rails.application.config.light_color = "#E6EDE8"

	article_config_hash = {biography: 
													{xml: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulBiography.xml",
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/BiographyXSLTstylesheet.xsl"
													},
												timeline: 
													{xml: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulTimeLineTEI.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/TEITimeLineList.xsl"
													 },
												bibliography: 
													{xml: "https://bitbucket.org/jeffreycwitt/bibliography/raw/master/bibliography.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/bibliography.xsl"
													},
												about: 	
													{xml: "https://bitbucket.org/jeffreycwitt/pp-about/raw/master/pp-about.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/about_stylesheet.xsl"
													}
												}

	Rails.application.config.article_config_hash = article_config_hash

	commentaryid = "plaoulcommentary"
	Rails.application.config.commentaryid = commentaryid
	commentarydirname = 'pp-projectfiles'
	Rails.application.config.confighash = confighash(commentarydirname)
end
def set_gracilis_config

	Rails.application.config.logo = "Petrus Gracilis"
	Rails.application.config.title = "The Commentary on the Sentences of Peter Gracilis"
	Rails.application.config.bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
	Rails.application.config.biography = false
	Rails.application.config.bibliography = true
	Rails.application.config.timeline = false
	Rails.application.config.about = true
	Rails.application.config.blog = false
	Rails.application.config.default_ms_image = "'lon'" #single quotes are required here in order to pass a string as parameter into Nokogir
	Rails.application.config.dark_color = "#F2D5D9"
	Rails.application.config.light_color = "#F9EFF1"

	article_config_hash = {biography: 
													{xml: "https://bitbucket.org/jeffreycwitt/pg-biography/raw/master/pg-biography.xml",
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/BiographyXSLTstylesheet.xsl"
													},
												timeline: 
													{xml: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulTimeLineTEI.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/TEITimeLineList.xsl"
													 },
												bibliography: 
													{xml: "https://bitbucket.org/jeffreycwitt/pg-bibliography/raw/master/pg-bibliography.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/bibliography.xsl"
													},
												about: 	
													{xml: "https://bitbucket.org/jeffreycwitt/pg-about/raw/master/pg-about.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/about_stylesheet.xsl"
													}
												}

	Rails.application.config.article_config_hash = article_config_hash

	commentaryid = "graciliscommentary"
	Rails.application.config.commentaryid = commentaryid
	commentarydirname = 'pg-projectfiles'
	Rails.application.config.confighash = confighash(commentarydirname)
end
def set_wodeham_config

	Rails.application.config.logo = "Adam Wodeham"
	Rails.application.config.title = "The Ordinatio Commentary on the Sentences of Adam Wodeham"
	Rails.application.config.bannermessage = "A working edition of Adam Wodeham's Ordinatio Commentary on the Sentences of Peter Lombard"
	Rails.application.config.biography = true
	Rails.application.config.bibliography = true
	Rails.application.config.timeline = false
	Rails.application.config.about = true
	Rails.application.config.blog = false
	Rails.application.config.default_ms_image = "'sorb'" #single quotes are required here in order to pass a string as parameter into Nokogir
	Rails.application.config.dark_color = "#bbbbce"
	Rails.application.config.light_color = "#e6e6ed"

	article_config_hash = {biography: 
													{xml: "https://bitbucket.org/jeffreycwitt/aw-biography/raw/master/aw-biography.xml",
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/BiographyXSLTstylesheet.xsl"
													},
												bibliography: 
													{xml: "https://bitbucket.org/jeffreycwitt/aw-bibliography/raw/master/aw-bibliography.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/bibliography.xsl"
													},
												about: 	
													{xml: "https://bitbucket.org/jeffreycwitt/aw-about/raw/master/aw-about.xml", 
													 xslt: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/about_stylesheet.xsl"
													}
												}

	Rails.application.config.article_config_hash = article_config_hash

	commentaryid = "wodehamordinatio"
	Rails.application.config.commentaryid = commentaryid
	commentarydirname = 'aw-projectfiles'
	Rails.application.config.confighash = confighash(commentarydirname)
end

def confighash (projectfiledir)
		confighash = {local_texts_dir: "/Users/JCWitt/WebPages/lbplib-testfiles/#{projectfiledir}/GitTextfiles/", 
									citation_lists_dir: "/Users/JCWitt/WebPages/lbplib-testfiles/#{projectfiledir}/citationlists/", 
									xslt_dirs: { "default" => {
										critical: "/Users/JCWitt/WebPages/lombardpress2/xslt/default/critical/",
										documentary: "/Users/JCWitt/WebPages/lombardpress2/xslt/default/critical/", 
										main_view: "main_view.xsl",
										index_view: "text_display_index.xsl", 
										clean_view: "clean_view.xsl",
										plain_text: "plaintext.xsl",
										json: "LbpToJson.xsl", 
										toc: "lectio_outline.xsl"
										}
									},
								git_repo: "bitbucket.org/jeffreycwitt/",
								git_username: ENV["GUN"],
								git_password: ENV["GPW"]
							}
	return confighash
end