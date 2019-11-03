# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    association :user
    name { "Moriarty" }
  end
end
