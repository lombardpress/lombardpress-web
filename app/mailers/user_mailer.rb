class UserMailer < ApplicationMailer
	def welcome_email(user)
  	@user = user
  	@url = "https://nameless-shelf-9637.herokuapp.com/users/sign_in"
  	mail(to: @user.email, subject: "Welcome to LomardPress")
  end
  def alpha_invitation(user)

  	@user = user
  	@url = "https://lombardpress2.herokuapp.com/users/sign_in"
  	mail(to: @user.email, from: 'jeffreycwitt@gmail.com', subject: "You've been invited to alpha test the new LombardPress2 rebuild")
  end
end
