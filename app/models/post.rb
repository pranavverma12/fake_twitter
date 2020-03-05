# frozen_string_literal: true

class Post < ApplicationRecord
  DESCRIPTION_MIN_LENGTH = 10

  belongs_to :user

  validates :user_id, :description, presence: true
  validates :description, length: { minimum: DESCRIPTION_MIN_LENGTH },
                       		if: -> { description }

  default_scope -> { order(created_at: :desc) }
end
