class UserMailer < ActionMailer::Base
  default from: "Drylab <noreply@drylab.io>"

  def signup_email(user)
    @user = user
    @twitter_message = "#Filmmaking is evolving. Excited for @drylab 3 to launch. Check it out:"
    mail(to: user.email, subject: "Thanks for signing up!")
  end
end
