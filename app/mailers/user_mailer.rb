class UserMailer < ActionMailer::Base
  default from: "Drylab <noreply@drylab.io>"

  def signup_email(user)
    @user = user
    @twitter_message = "#Film-making is evolving. Excited for @drylab 3 to launch."
    mail(to: user.email, subject: "Thanks for signing up!")
  end
end
