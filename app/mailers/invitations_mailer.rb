# frozen_string_literal: true

class InvitationsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitations_mailer.notify_invitee.subject
  #
  def notify_invitee(invitation)
    @invitation = invitation

    mail(
      :subject => translate(".subject", :group_name => invitation.group.name),
      :to => invitation.email
    )
  end
end
