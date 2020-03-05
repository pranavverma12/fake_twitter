# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:description) { |i| "This is my blog number #{i}" }
    photo { "" }
    user {User.first_or_create(username: 'newuser', email: 'newuser@example.org', password: 'securePassword', password_confirmation: 'securePassword')}
  end
end
