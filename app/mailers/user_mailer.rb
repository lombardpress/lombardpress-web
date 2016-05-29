class UserMailer < ApplicationMailer
	def welcome_email(user)
  	@user = user
  	@url = "https://nameless-shelf-9637.herokuapp.com/users/sign_in"
  	mail(to: @user.email, subject: "Welcome to LombardPress")
  end
  def alpha_invitation(user, host_link)

  	@user = user
  	@host_link = host_link
  	mail(to: @user.email, from: 'jcwitt@loyola.edu', subject: "You've been invited to alpha test the new LombardPress2 rebuild")
  end
end
