# frozen_string_literal: true

require "rails_helper"

RSpec.describe "OwnerInvitesNewMemberToGroup", :type => :system do
  before do
    driven_by(:rack_test)
  end

  let(:group) { FactoryBot.create(:group) }

  let(:owner) { FactoryBot.create(:user) }

  before do
    group.members << FactoryBot.create(:member, :user => owner)

    visit new_user_session_url
    fill_in("Email", :with => owner.email)
    fill_in("Password", :with => "verysecret")
    click_button("Log in")
  end

  it "invites the new member" do
    visit group_members_path(group)
    click_link I18n.translate("members.index.add_member")

    fill_in("Email", :with => "doofenshmirtz@evilinc.co")
    click_button(I18n.translate("helpers.submit.invitation.create"))

    expect(current_path).to eq(group_members_path(group))
  end
end
