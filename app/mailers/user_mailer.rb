class UserMailer < ActionMailer::Base
  default from: "Drylab <create.drylab.io>"

  def signup_email(user)
    @user = user
    @twitter_message = "#Film-making is evolving. Excited for @drylab 3 to launch."
    mail(to: user.email, from: 'noreply@create.drylab.io', subject: "Thanks for signing up!")
  end
end
