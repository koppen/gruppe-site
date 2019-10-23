# frozen_string_literal: true

require "rails_helper"

RSpec.describe AddUserToGroup do
  let(:user) { FactoryBot.build(:user) }

  subject { described_class.new(user) }

  context "when attributes are valid" do
    let(:group) { FactoryBot.create(:group) }
    let(:new_user) { FactoryBot.create(:user) }

    it "creates a Membership" do
      expect {
        subject.process(new_user, group)
      }.to change {
        Membership.count
      }.by(1)
    end

    it "creates a Member" do
      expect {
        subject.process(new_user, group)
      }.to change {
        Member.count
      }.by(1)
    end

    it "is a success" do
      subject.process(new_user, group)
      expect(subject).to be_success
    end

    it "returns a Membership as result" do
      subject.process(new_user, group)
      expect(subject.result).to be_a(Membership)
    end

    it "adds the user as a member of the group" do
      subject.process(new_user, group)
      created_membership = subject.result
      expect(created_membership.member.user).to eq(new_user)
    end
  end
end
