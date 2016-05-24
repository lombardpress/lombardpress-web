class AccessMailer < ApplicationMailer

	def request_access(user, itemid, commentaryid)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
  	mail(to: 'jeffreycwitt@gmail.com', from: @user.email, subject: "New Access Request")
	end
	def confirm_request_access(user, itemid, commentaryid)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		binding.pry
		if @itemid == 'all'
			@item_title = "all items"
		else
			url = "http://scta.info/resource/#{@itemid}"
			item = Lbp::Expression.new(url)
			@item_title = item.title
		end
		mail(to: @user.email, from: 'jeffreycwitt@gmail.com', subject: "Confirmation of Access Request")
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
			item = Lbp::Expression.new(url)
			@item_title = item.title
		end
  	
  	mail(to: @user.email, from: 'jeffreycwitt@gmail.com', subject: "You've Been Granted Access")
	end
end
