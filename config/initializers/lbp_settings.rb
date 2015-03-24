#These configs need to eventually be put in a yaml find and then pulled out 
Rails.application.config.logo = "PetrusPlaoul"
Rails.application.config.title = "The Commentary on the Sentences of Peter Plaoul"
Rails.application.config.bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
Rails.application.config.biography = true
Rails.application.config.bibliography = true
Rails.application.config.timeline = true
Rails.application.config.about = true
Rails.application.config.blog = false
Rails.application.config.default_ms_image = "'reims'" #single quotes are required here in order to pass a string as parameter into Nokogir


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
commentaryid = "plaoulcommentary"
#commentaryid = "wodehamordinatio"
#commentaryid = "graciliscommentary"
Rails.application.config.commentaryid = commentaryid
commentarydirname = 'pp-projectfiles'


commentaries = {
	wodehamordinatio: confighash("aw-projectfiles"), 
	plaoulcommentary: confighash("pp-projectfiles"),
	graciliscommentary: confighash("pg-projectfiles"),
	lambertuscommentary: confighash("lm-projectfiles"),
	werlcommentary: confighash("hw-projectfiles")
}

Rails.application.config.confighash = confighash(commentarydirname)