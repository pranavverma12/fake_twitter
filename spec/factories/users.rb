# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "someusername#{i}" }
    sequence(:email) { |i| "someemail#{i}@learnsignals.ie" }
    password { 'MyBigLongPasswordDigest' }
    password_confirmation { password }
  end
end
