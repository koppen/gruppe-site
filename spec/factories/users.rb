# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "foo#{rand(1_000)}@example.com" }
    password { "verysecret" }
  end
end
