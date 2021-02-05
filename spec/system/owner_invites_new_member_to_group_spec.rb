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

    login_as(owner)
  end

  it "invites the new member" do
    visit group_members_path(group)
    click_link I18n.translate("members.index.add_member")

    fill_in("Email", :with => "doofenshmirtz@evilinc.co")
    click_button(I18n.translate("helpers.submit.invitation.create"))

    expect(page).to have_current_path(group_members_path(group), :ignore_query => true)
  end
end
