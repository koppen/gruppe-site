# frozen_string_literal: true

require "rails_helper"

RSpec.describe AddUserToGroup do
  subject { described_class.new(user) }

  let(:user) { FactoryBot.build(:user) }

  context "when attributes are valid" do
    let(:group) { FactoryBot.create(:group) }
    let(:new_user) { FactoryBot.create(:user) }

    it "creates a Member" do
      expect {
        subject.process(new_user, group)
      }.to change(Member, :count).by(1)
    end

    it "creates a Membership" do
      expect {
        subject.process(new_user, group)
      }.to change(Membership, :count).by(1)
    end

    it "is a success" do
      subject.process(new_user, group)
      expect(subject).to be_success
    end

    it "returns a Member as result" do
      subject.process(new_user, group)
      expect(subject.result).to be_a(Member)
    end

    it "adds the user as a member of the group" do
      subject.process(new_user, group)
      created_member = subject.result
      expect(created_member.membership.user).to eq(new_user)
    end
  end
end
