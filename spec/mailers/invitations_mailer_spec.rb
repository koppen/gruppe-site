# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvitationsMailer, :type => :mailer do
  describe "notify_invitee" do
    let(:invitation) { FactoryBot.create(:invitation) }
    let(:mail) { InvitationsMailer.notify_invitee(invitation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation to join #{invitation.group}")
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to \
        include(invitation_url(:id => invitation.token))
    end
  end
end
