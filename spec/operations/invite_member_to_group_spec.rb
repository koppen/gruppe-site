# frozen_string_literal: true

require "rails_helper"

RSpec.describe InviteMemberToGroup do
  subject { described_class.new(user) }

  let(:group) { FactoryBot.build(:group) }

  let(:user) { FactoryBot.build(:user) }

  context "when email_address is valid" do
    let(:email_address) { "no@spectre.org" }

    it "creates an invitation" do
      expect {
        subject.process(email_address, group)
      }.to change(Invitation, :count).by(1)
    end

    it "returns the created invitation in result" do
      subject.process(email_address, group)
      expect(subject.result).to be_instance_of(Invitation)
    end

    it "is a success" do
      subject.process(email_address, group)
      expect(subject).to be_success
    end

    it "adds the invitation to the group" do
      subject.process(email_address, group)
      created_invitation = subject.result
      expect(group.invitations.first).to eq(created_invitation)
    end

    it "creates a token for the invitation" do
      subject.process(email_address, group)
      created_invitation = subject.result
      expect(created_invitation.token).to be_present
    end

    it "notifies the invitee via email" do
      expect {
        subject.process(email_address, group)
      }.to have_enqueued_job.on_queue("mailers").with(subject.result)
    end
  end

  context "when email_address are invalid" do
    let(:email_address) { "" }

    it "does not create an invitation" do
      expect {
        subject.process(email_address, group)
      }.not_to change(Invitation, :count)
    end

    it "is not a success" do
      subject.process(email_address, group)
      expect(subject).not_to be_success
    end
  end
end
