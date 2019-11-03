# frozen_string_literal: true

FactoryBot.define do
  factory :group_user do
    association :group
    association :membership
  end
end
