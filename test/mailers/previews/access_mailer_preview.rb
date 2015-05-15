# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class AccessMailerPreview < ActionMailer::Preview
	
	def confirm_request_access
		@config = LbpConfig.new("plaoulcommentary.lombardpress.org")
		AccessMailer.confirm_request_access(User.find(3), 'lectio1', 'plaoulcommentary', @config.confighash)
	end
	def grant_access
		@config = LbpConfig.new("plaoulcommentary.lombardpress.org")
		AccessMailer.grant_access(User.find(3), 'lectio1', 'plaoulcommentary', @config.confighash)
	end
	def request_access
		AccessMailer.request_access(User.find(3), 'lectio1', 'plaoulcommentary')
	end
end
