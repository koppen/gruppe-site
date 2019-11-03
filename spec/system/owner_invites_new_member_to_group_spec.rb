# frozen_string_literal: true

require "rails_helper"

RSpec.describe "OwnerInvitesNewMembershipToGroup", :type => :system do
  before do
    driven_by(:rack_test)
  end

  let(:group) { FactoryBot.create(:group) }

  let(:owner) { FactoryBot.create(:user) }

  before do
    group.memberships << FactoryBot.create(:membership, :user => owner)

    visit new_user_session_url
    fill_in("Email", :with => owner.email)
    fill_in("Password", :with => "verysecret")
    click_button("Log in")
  end

  it "invites the new member" do
    visit group_memberships_path(group)
    click_link I18n.translate("memberships.index.add_member")

    fill_in("Email", :with => "doofenshmirtz@evilinc.co")
    click_button(I18n.translate("helpers.submit.invitation.create"))

    expect(current_path).to eq(group_memberships_path(group))
  end
end
