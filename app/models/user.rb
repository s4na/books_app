# frozen_string_literal: true

class User < ApplicationRecord
  paginates_per 5

  has_one_attached :icon

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: %i(google facebook github)

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(
        name:     auth.extra.raw_info.name,
        provider: auth.provider,
        uid:      auth.uid,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    clean_up_passwords
    update_attributes(params, *options)
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  has_many :follows
  has_many :followings, through: :follows, source: :follow
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "follow_id"
  has_many :followers, through: :reverse_of_follows, source: :user

  def follow(other_user)
    unless self == other_user
      self.follows.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    follow = self.follows.find_by(follow_id: other_user.id)
    follow.destroy if follow
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
