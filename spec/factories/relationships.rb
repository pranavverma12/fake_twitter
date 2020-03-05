# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    follower_id { User.first_or_create(username: 'newuser2', email: 'newuser2@example.org', password: 'securePassword', password_confirmation: 'securePassword').id }
    followed_id { User.first_or_create(username: 'newuser1', email: 'newuser1@example.org', password: 'securePassword', password_confirmation: 'securePassword').id }
  end
end
