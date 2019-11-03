# frozen_string_literal: true

require "rails_helper"

RSpec.describe Group, :type => :model do
  it { should validate_presence_of(:name) }

  it { should have_many(:invitations) }

  it { should have_many(:members) }
  it { should have_many(:memberships).through(:members) }

  it "presents itself by name" do
    expect(subject.to_s).to eq(subject.name)
  end
end
