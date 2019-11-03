# frozen_string_literal: true

require "rails_helper"

RSpec.describe MembershipsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:group) { FactoryBot.create(:group) }

  let(:valid_attributes) { FactoryBot.attributes_for(:membership) }

  context "when logged in as a member of the group" do
    let(:current_user) { member.membership.user }
    let(:member) { FactoryBot.create(:member, :group => group) }
    let(:membership) { member.membership }

    before do
      sign_in(current_user, :scope => :user)
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, :params => {:group_id => group.to_param}
        expect(response).to be_successful
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {:name => "J. Wiseman"}
        }

        it "updates the requested membership" do
          put :update,
              :params => {
                :group_id => group.to_param,
                :membership => new_attributes,
              }
          membership.reload
          expect(membership.name).to eq("J. Wiseman")
        end

        it "redirects to the group" do
          put :update,
              :params => {
                :group_id => group.to_param,
                :membership => valid_attributes,
              }
          expect(response).to redirect_to(group)
        end
      end
    end

    describe "GET #destroy" do
      it "returns http success" do
        pending
        get :destroy
        expect(response).to have_http_status(:success)
      end
    end
  end
end
