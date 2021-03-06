class User < ApplicationRecord
  has_secure_password
  has_many :healths
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates :password, presence: true, on: :creates
  validates :password, presence: true, on: :update, allow_blank: true
  validates :password, confirmation: true

  def self.from_omniauth(auth_info)
    return if auth_info.nil?
    where(uid: auth_info[:uid]).first_or_create! do |new_user|
      new_user.email              =  rand(1..888)
      new_user.password           =  "from twitter"
      new_user.location           =   "Kenosha"
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end
