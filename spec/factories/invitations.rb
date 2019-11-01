# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    association :group
    association :user

    email { "new@example.com" }
    token { "randomstring" }
  end
end
