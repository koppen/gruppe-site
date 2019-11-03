# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveMemberFromGroup do
  let(:group) { FactoryBot.create(:group) }
  let(:membership) { FactoryBot.create(:membership) }
  let(:user) { FactoryBot.build(:user) }

  subject { described_class.new(user) }

  context "when member is a member of group" do
    before do
      group.memberships << membership
    end

    it "deletes the group_user" do
      expect {
        subject.process(membership, group)
      }.to change {
        GroupUser.count
      }.by(-1)
    end

    it "deletes the member" do
      expect {
        subject.process(membership, group)
      }.to change {
        Membership.count
      }.by(-1)
    end

    it "is a success" do
      subject.process(membership, group)
      expect(subject).to be_success
    end

    it "returns the removed group_user in result" do
      subject.process(membership, group)
      expect(subject.result).to be_a(GroupUser)
    end
  end
end
