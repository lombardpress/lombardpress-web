# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def alpha_invitation
		#config = LbpConfig.new("plaoulcommentary.lombardpress.org")
		UserMailer.alpha_invitation(User.find(3), 'plaoulcommentary.lombardpress.org')
	end
end
