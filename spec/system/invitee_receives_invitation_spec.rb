# frozen_string_literal: true

require "rails_helper"

RSpec.describe "New member receives invitation", :type => :system do
  before do
    driven_by(:rack_test)
  end

  let(:group) { invitation.group }
  let(:invitation) { FactoryBot.create(:invitation) }

  context "when invitee is already a user" do
    let(:invitee) { FactoryBot.create(:user, :email => invitation.email) }

    context "and is logged in" do
      before do
        visit new_user_session_url
        fill_in("Email", :with => invitee.email)
        fill_in("Password", :with => "verysecret")
        click_button("Log in")
      end

      it "accepts the invitation" do
        visit invitation_url(:id => invitation.token)
        click_button(
          I18n.translate("invitations.show.join", :group_name => group.name)
        )

        expect(group.memberships.map(&:email)).to include(invitation.email)
        expect { invitation.reload }.to \
          raise_error(ActiveRecord::RecordNotFound)
        expect(page).to have_current_path(group_path(group), :ignore_query => true)
      end

      it "rejects the invitation" do
        visit invitation_url(:id => invitation.token)
        click_button I18n.translate("invitations.show.reject")

        expect(group.memberships.map(&:email)).not_to include(invitation.email)
        expect { invitation.reload }.to \
          raise_error(ActiveRecord::RecordNotFound)
        expect(page).to have_current_path(root_path, :ignore_query => true)
      end
    end
  end
end
