#These configs need to eventually be put in a yaml find and then pulled out 
Rails.application.config.logo = "PetrusPlaoul"
Rails.application.config.title = "The Commentary on the Sentences of Peter Plaoul"
Rails.application.config.bannermessage = "A working edition of the Commentary on the Sentences of Peter Lombard"
Rails.application.config.biography = true
Rails.application.config.bibliography = true
Rails.application.config.default_ms_image = "'lon'" #single quotes are required here in order to pass a string as parameter into Nokogir




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
#commentaryid = "plaoulcommentary"
commentaryid = "graciliscommentary"
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