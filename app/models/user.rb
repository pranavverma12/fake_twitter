# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  USERNAME_MAX_LENGTH = 30
  USERNAME_MIN_LENGTH = 4

  PASSWORD_MIN_LENGTH = 10
  PASSWORD_MAX_LENGTH = 200

  EMAIL_MAX_LENGTH = 200
  EMAIL_REGEX = /\A([a-z0-9\+_\-\']+)(\.[a-z0-9\+_\-\']+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix.freeze

  before_validation :downcase
  before_validation :strip_whitespace

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :posts, dependent: :destroy

  validates :email, :username, :password, presence: true

  validates :email, length: { maximum: EMAIL_MAX_LENGTH,
                              if: :email }
  validates :email, format: { with: EMAIL_REGEX },
                    if: -> { errors[:email].blank? }
  validates :email, uniqueness: { case_sensitive: false },
                    if: -> { errors[:username].blank? }

  validates :username, no_spaces: true, if: -> { errors[:username].blank? }
  validates :username, number_of_lines: { maximum: 1 },
                       if: -> { errors[:username].blank? }
  validates :username, format: { with: /\A[a-zA-Z0-9]*\Z/ },
                       if: -> { errors[:username].blank? }
  validates :username, length: { minimum: USERNAME_MIN_LENGTH,
                                 maximum: USERNAME_MAX_LENGTH },
                       if: -> { username }
  validates :username, uniqueness: { case_sensitive: false },
                       if: -> { errors[:username].blank? }

  validates :password, no_spaces: true,
                       if: -> { password && errors[:password].blank? }
  validates :password, number_of_lines: { maximum: 1 },
                       if: -> { password && errors[:password].blank? }
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH,
                                 maximum: PASSWORD_MAX_LENGTH },
                       if: -> { password && errors[:password].blank? }

  scope :search, lambda { |option|
                   where('username like ? or email like ?', "%#{option}%",
                         "%#{option}%")
                 }

  # Follow a User
  def follow(other_user)
    following << other_user
  end

  # Unfollows a User.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other User.
  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  private

  def strip_whitespace
    email&.strip!
    username&.strip!
  end

  def downcase
    email&.downcase!
  end
end
