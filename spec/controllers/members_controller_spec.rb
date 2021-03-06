# frozen_string_literal: true

require "rails_helper"

RSpec.describe MembersController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:group) { FactoryBot.create(:group) }
  let(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    FactoryBot.attribute_for(:member)
  }

  let(:invalid_attributes) {
    {
      :group_id => 0,
      :user_id => 0,
    }
  }

  let(:valid_session) { {} }

  before do
    group.memberships.create!(:user => user)
  end

  context "when logged in" do
    before do
      sign_in(user, :scope => :user)
    end

    describe "GET #index" do
      it "returns a success response" do
        # Membership.create! valid_attributes
        get :index,
            :params => {:group_id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      let!(:member) { FactoryBot.create(:member, :group => group) }

      it "destroys the requested member" do
        expect {
          delete :destroy,
                 :params => {
                   :group_id => group.to_param,
                   :id => member.to_param,
                 },
                 :session => valid_session
        }.to change(Membership, :count).by(-1)
      end

      it "removes the member from the group" do
        expect {
          delete :destroy,
                 :params => {
                   :group_id => group.to_param,
                   :id => member.to_param,
                 },
                 :session => valid_session
        }.to change {
          group.memberships.count
        }.by(-1)
      end

      it "redirects to the members list" do
        delete :destroy,
               :params => {
                 :group_id => group.to_param,
                 :id => member.to_param,
               },
               :session => valid_session
        expect(response).to redirect_to(group_members_path(group))
      end
    end
  end
end
