# frozen_string_literal: true

require "rails_helper"

RSpec.describe Group, :type => :model do
  it { should validate_presence_of(:name) }

  it "presents itself by name" do
    expect(subject.to_s).to eq(subject.name)
  end
end
