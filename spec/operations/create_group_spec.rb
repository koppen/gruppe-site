# frozen_string_literal: true

require "rails_helper"

RSpec.describe CreateGroup do
  let(:user) { FactoryBot.build(:user) }

  subject { described_class.new(user) }

  context "when attributes are valid" do
    let(:attributes) { FactoryBot.attributes_for(:group) }

    it "creates a group" do
      expect {
        subject.process(attributes)
      }.to change {
        Group.count
      }.by(1)
    end

    it "returns the created group in result" do
      expect {
        subject.process(attributes)
      }.to change {
        Group.count
      }.by(1)
    end

    it "is a success" do
      subject.process(attributes)
      expect(subject).to be_success
    end

    it "adds the user as a member of the group" do
      subject.process(attributes)
      created_group = subject.result
      expect(created_group.memberships.first.user).to eq(user)
    end
  end

  context "when attributes are invalid" do
    let(:attributes) { {:name => ""} }

    it "does not create an invalid group" do
      expect {
        subject.process(attributes)
      }.to_not change {
        Group.count
      }
    end

    it "is not a success" do
      subject.process(attributes)
      expect(subject).to_not be_success
    end
  end
end
