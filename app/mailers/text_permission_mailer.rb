class TextPermissionMailer < ApplicationMailer

	def request_permission
		@message = "requesting permission."
		 
		mail(to: "jeffreycwitt@gmail.com", from: "jeff@lombardpress.org", subject: "test send")
	end
end
