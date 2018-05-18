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
      'count' => 2,
      'html' => 'Junior',
      'class' => 'one',
      'description' => "Off to a good start! Keep on going.",
      'prize' => "$100"
    },
    {
      'count' => 4,
      'html' => 'Employee of the Month',
      'class' => 'two',
      'description' => "Your mama would be proud.",
      'prize' => "$200"
    },
    {
      'count' => 6,
      'html' => 'Expert Networker',
      'class' => 'three',
      'description' => "Wow! You're on fire!!",
      'prize' => "$300"
    },
    {
      'count' => 8,
      'html' => 'Honorary Citizen',
      'class' => 'four',
      'description' => "*ERROR* <br> Failed to come up with funny punch.",
      'prize' => "$400"
    },
    {
      'count' => 10,
      'html' => 'Super Ninja',
      'class' => 'five',
      'description' => "Are you even human?",
      'prize' => "$500"
    },
    {
      'count' => 12,
      'html' => 'Prodigy',
      'class' => 'six',
      'description' => "Do you really know all of these people? Impressive!",
      'prize' => "$600"
    },
    {
      'count' => 14,
      'html' => 'Emperor of Networking',
      'class' => 'seven',
      'description' => "Words are not enough. We bow before you.",
      'prize' => "$700"
    },
    {
      'count' => 16,
      'html' => 'Master of the Universe',
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
