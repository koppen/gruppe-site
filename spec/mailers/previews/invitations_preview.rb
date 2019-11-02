# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/invitations
class InvitationsPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/invitations/notify_invitee
  def notify_invitee
    invitation = FactoryBot.create(:invitation)
    InvitationsMailer.notify_invitee(invitation)
  end
end
