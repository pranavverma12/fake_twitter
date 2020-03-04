# frozen_string_literal: true

class Post < ApplicationRecord
  DESCRIPTION_MIN_LENGTH = 10

  attr_accessor :photo_file_name

  belongs_to :user

  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: DESCRIPTION_MIN_LENGTH }

  default_scope -> { order(created_at: :desc) }
end
