class AccessMailer < ApplicationMailer

	def request_access(user, itemid, commentaryid)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
  	mail(to: 'jeffreycwitt@gmail.com', from: @user.email, subject: "New Access Request")
	end
	def confirm_request_access(user, itemid, commentaryid, config_hash)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		if @itemid == 'all'
			@item_title = "all items"
		else
			url = "http://scta.info/text/#{@commentaryid}/item/#{@itemid}"
			item = Lbp::Item.new(config_hash, url)
			@item_title = item.title
		end
		mail(to: @user.email, from: 'jeffreycwitt@gmail.com', subject: "Confirmation of Access Request")
	end
	def grant_access(user, itemid, commentaryid, config_hash)
		@user = user
		@itemid = itemid
		@commentaryid = commentaryid
		if @itemid == 'all'
			@item_title = "all items"
		else
			url = "http://scta.info/text/#{@commentaryid}/item/#{@itemid}"
			item = Lbp::Item.new(config_hash, url)
			@item_title = item.title
		end
  	
  	mail(to: @user.email, from: 'jeffreycwitt@gmail.com', subject: "You've Been Granted Access")
	end
end
