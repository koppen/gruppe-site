# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    group { nil }
    membership { nil }
    body { "My Long Text" }
    raw_text_body { "My Long Text" }
    raw_html_body { "<p>My <b>Long</b> Text</p>" }
  end
end
