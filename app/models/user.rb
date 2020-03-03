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

  validates :email, presence: true
  validates :email, length: { maximum: EMAIL_MAX_LENGTH,
                              if: :email }
  validates :email, format: { with: EMAIL_REGEX },
                    if: -> { errors[:email].blank? }

  validates :username, presence: true
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

  validates :username, presence: true
  validates :password, no_spaces: true,
                       if: -> { password && errors[:password].blank? }
  validates :password, number_of_lines: { maximum: 1 },
                       if: -> { password && errors[:password].blank? }
  validates :password, length: { minimum: PASSWORD_MIN_LENGTH,
                                 maximum: PASSWORD_MAX_LENGTH },
                       if: -> { password && errors[:password].blank? }

  private

  def strip_whitespace
    email&.strip!
    username&.strip!
  end

  def downcase
    email&.downcase!
  end
end
