# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

plaoul = Setting.create(commentaryid: "plaoulcommentary", logo: "Petrus Plaoul", title: "The Commentary on the Sentences of Peter Plaoul", bannermessage: "A working edition of Peter Plaoul's Commentary on the Sentences of Peter Lombard", blog: false, default_ms_image: "'reims'", dark_color: "#BBCEBE", light_color: "#E6EDE8", true)

		plaoulbio = Article.create(article_name: "biography", xml_file: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulBiography", xslt_file: "/xslt/articles/biography.xsl"

		plaoultimeline = Article.create(article_name: "timeline", xml_file: "https://bitbucket.org/jeffreycwitt/biography/raw/master/PlaoulTimeLineTEI", xslt_file: "/xslt/articles/timeline.xsl")

		plaoulbib = Article.create(article_name: "bibliography", xml_file: "https://bitbucket.org/jeffreycwitt/bibliography/raw/master/bibliography", xslt_file: "/xslt/articles/bibliography.xsl")

		plaoulabout = Article.create(article_name: "about", xml_file: "https://bitbucket.org/jeffreycwitt/pp-about/raw/master/pp-about.xml", xslt_file: "/xslt/articles/standard.xsl")

		plaoulmss = Article.create(article_name: "manuscripts", xml_file: "https://bitbucket.org/jeffreycwitt/bibliography/raw/master/PlaoulTexts.xml", xslt_file: "/xslt/articles/bibliography.xsl")

adam = Setting.create(commentaryid: "wodehamordinatio", logo: "Adam Wodeham", title: "The Ordinatio Commentary on the Sentences by Adam Wodeham", bannermessage: "A working edition of Adam Wodeham's Ordinatio Commentary on the Sentences of Peter Lombard", blog: false, default_ms_image: "'sorb'", dark_color: "#bbbbce", light_color: "#e6e6ed", images: false)

		adambio = Article.create(article_name: "biography", xml_file: "https://bitbucket.org/jeffreycwitt/aw-biography/ra...", xslt_file: "/xslt/articles/biography.xsl")

		adambib = Article.create(article_name: "bibliography", xml_file: "https://bitbucket.org/jeffreycwitt/aw-bibliography...", xslt_file: "/xslt/articles/bibliography.xsl")

		adamabout = Article.create(article_name: "about", xml_file: "https://bitbucket.org/jeffreycwitt/aw-about/raw/ma...", xslt_file: "/xslt/articles/standard.xsl")

		adammss = Article.create(article_name: "manuscripts", xml_file: "https://bitbucket.org/jeffreycwitt/aw-manuscripts/...", xslt_file: "/xslt/articles/standard.xsl")

gracilis = Setting.create(commentaryid: "graciliscommentary", logo: "Peter Gracilis", title: "The Commentary on the Sentences by Peter Gracilis", bannermessage: "A Working Edition of the Commentary on the Sentences of Peter Lombard by Peter Gracilis", blog: false, default_ms_image: "'lon'", dark_color: "#F2D5D9", light_color: "#F9EFF1", images: true)

		gracbio = Article.create(article_name: "biography", xml_file: "https://bitbucket.org/jeffreycwitt/pg-biography/ra...", xslt_file: "/xslt/articles/biography.xsl")

		gracbib = Article.create(article_name: "bibliography", xml_file: "https://bitbucket.org/jeffreycwitt/pg-bibliography...", xslt_file: "/xslt/articles/bibliography.xsl")

		gracabout = Article.create(article_name: "about", xml_file: "https://bitbucket.org/jeffreycwitt/pg-about/raw/ma...", xslt_file: "/xslt/articles/standard.xsl")

olivi = Setting.create(commentaryid: "olivicommentary", logo: "Peter John Olivi", title: "The Commentary on the Sentences by Peter John Olivi", bannermessage: "A Revised Edition of the Commentary on the Sentences of Peter Lombard by Peter John Olivi", blog: false, default_ms_image: "'vat'", dark_color: "#BAAA8D", light_color: "#ECE7E0", images: false)

		oliviabout = Article.create(article_name: "about", xml_file: "https://bitbucket.org/jeffreycwitt/pjo-about/raw/master/pjo-about.xml", xslt_file: "/xslt/articles/standard.xsl")