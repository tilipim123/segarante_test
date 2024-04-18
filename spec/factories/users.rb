# frozen_string_literal: true

# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "john#{n}" }
    sequence(:email) { |n| "john#{n}@example.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
