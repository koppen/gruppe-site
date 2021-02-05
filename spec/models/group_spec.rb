# frozen_string_literal: true

require "rails_helper"

RSpec.describe Group, :type => :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:invitations) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:members) }
  it { is_expected.to have_many(:memberships).through(:members) }

  it "presents itself by name" do
    expect(subject.to_s).to eq(subject.name)
  end
end
