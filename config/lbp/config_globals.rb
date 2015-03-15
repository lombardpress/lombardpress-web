$confighash = { texts_dir: "/Users/JCWitt/WebPages/lbplib-testfiles/GitTextfiles/", 
		projectdatafile_dir: "/Users/JCWitt/WebPages/lbplib-testfiles/Conf/", 
		xslt_critical_dir: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/",
		xslt_documentary_dir: "/Users/JCWitt/WebPages/lbpwrapper/lombardpress/public/pl_xslt_stylesheets/", 
		xslt_main_view: "text_display.xsl",
		xslt_index_view: "text_display_index.xsl", 
		xslt_clean: "clean_forStatistics.xsl",
		xslt_plain_text: "plaintext.xsl", 
		xslt_toc: "lectio_outline.xsl",
		git_repo: "bitbucket.org/jeffreycwitt/"}

$pp_projectfile = "/Users/JCWitt/WebPages/lbpapp.rb/pp-projectfiles/Conf/projectfile.xml"
#$pp_projectfile = "/Users/JCWitt/WebPages/lbplib-testfiles/pp-projectfiles/Conf/projectdata.xml"
$pg_projectfile = "/Users/JCWitt/WebPages/lbpapp.rb/pg-projectfiles/Conf/projectfile.xml"
$aw_projectfile = "/Users/JCWitt/WebPages/lbpapp.rb/aw-projectfiles/Conf/projectfile.xml"


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
							git_username: "jeffreycwitt",
							git_password: "plaoulRepo"
						}
	return confighash
end
#$commentaryid = "plaoulcommentary"
$commentaryid = "wodehamordinatio"
$commentarydirname = 'pp-projectfiles'
$commentaries = {
	wodehamordinatio: confighash("aw-projectfiles"), 
	plaoulcommentary: confighash("pp-projectfiles"),
	graciliscommentary: confighash("pg-projectfiles"),
	lambertuscommentary: confighash("lm-projectfiles"),
	werlcommentary: confighash("hw-projectfiles")
}


