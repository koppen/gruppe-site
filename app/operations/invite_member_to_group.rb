# frozen_string_literal: true

# Invites someone to join a Group
class InviteMemberToGroup < Substance::Operation
  def process(email_address, group)
    invitation = build_invitation(email_address, group)
    self.success = invitation.save
    self.result = invitation
    return unless success?

    notify_invitee(invitation)
  end

  private

  def build_invitation(email_address, group)
    Invitation.new(
      :email => email_address,
      :group => group,
      :user => user
    )
  end

  def notify_invitee(invitation)
    InvitationsMailer.notify_invitee(invitation).deliver_later
  end
end
