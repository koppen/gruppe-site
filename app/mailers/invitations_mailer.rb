# frozen_string_literal: true

class InvitationsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitations_mailer.notify_invitee.subject
  #
  def notify_invitee(invitation)
    @invitation = invitation

    mail(:to => invitation.email)
  end
end
