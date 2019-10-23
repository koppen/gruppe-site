# frozen_string_literal: true

require "rails_helper"

RSpec.describe RemoveMemberFromGroup do
  let(:group) { FactoryBot.create(:group) }
  let(:member) { FactoryBot.create(:member) }
  let(:user) { FactoryBot.build(:user) }

  subject { described_class.new(user) }

  context "when member is a member of group" do
    before do
      group.members << member
    end

    it "deletes the membership" do
      expect {
        subject.process(member, group)
      }.to change {
        Membership.count
      }.by(-1)
    end

    it "deletes the member" do
      expect {
        subject.process(member, group)
      }.to change {
        Member.count
      }.by(-1)
    end

    it "is a success" do
      subject.process(member, group)
      expect(subject).to be_success
    end

    it "returns the removed membership in result" do
      subject.process(member, group)
      expect(subject.result).to be_a(Membership)
    end
  end
end
