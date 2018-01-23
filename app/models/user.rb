require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 0,
      'html' => 'Beginner',
      'class' => 'zero',
      'description' => "Don't be shy, your friends would surely like to know.",
      'prize' => "$0"
    },
    {
      'count' => 5,
      'html' => 'Junior',
      'class' => 'one',
      'description' => "Off to a good start! Keep on going.",
      'prize' => "$100"
    },
    {
      'count' => 10,
      'html' => 'Employee of the month',
      'class' => 'two',
      'description' => "Your mama would be proud.",
      'prize' => "$200"
    },
    {
      'count' => 15,
      'html' => 'Expert networker',
      'class' => 'three',
      'description' => "Do you really know all of these people?",
      'prize' => "$300"
    },
    {
      'count' => 20,
      'html' => 'Honorary Citizen',
      'class' => 'four',
      'description' => "Wow! You're on fire!!",
      'prize' => "$400"
    },
    {
      'count' => 25,
      'html' => 'Super Ninja',
      'class' => 'five',
      'description' => "Are you even human?",
      'prize' => "$500"
    },
    {
      'count' => 30,
      'html' => 'Prodigy',
      'class' => 'six',
      'description' => "*ERROR* Failed to come up with funny punch.",
      'prize' => "$600"
    },
    {
      'count' => 35,
      'html' => 'Emperor of Networking',
      'class' => 'seven',
      'description' => "Words are not enough. We bow to you.",
      'prize' => "$700"
    },
    {
      'count' => 40,
      'html' => 'Master of the universe',
      'class' => 'eight',
      'description' => "Gordon's alive!",
      'prize' => "$800"
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self)
  end
end
