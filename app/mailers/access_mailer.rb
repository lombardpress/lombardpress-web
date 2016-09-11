class AccessMailer < ApplicationMailer

	def request_access(user, itemid, commentaryid, domain)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		@domain = domain
  	mail(to: 'jcwitt@loyola.edu', from: "jcwitt@loyola.edu", subject: "New Access Request")
	end
	def confirm_request_access(user, itemid, commentaryid, domain)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		@domain = domain
		if @itemid == 'all'
			@item_title = "all items"
		else
			url = "http://scta.info/resource/#{@itemid}"
			item = Lbp::Expression.find(url)
			@item_title = item.title
		end
		mail(to: @user.email, from: 'jcwitt@loyola.edu', subject: "Confirmation of Access Request")
	end
	def grant_access(user, itemid, commentaryid, domain)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		@domain = domain
		if @itemid == 'all'
			@item_title = "all items"
		else
			url = "http://scta.info/resource/#{@itemid}"
			item = Lbp::Expression.find(url)
			@item_title = item.title
		end

  	mail(to: @user.email, from: 'jcwitt@loyola.edu', subject: "You've Been Granted Access")
	end
end
