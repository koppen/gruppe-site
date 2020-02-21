# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvitationsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:group) { FactoryBot.create(:group) }
  let(:current_user) { FactoryBot.create(:user) }

  before do
    group.memberships.create(:user => current_user)
  end

  context "when logged in" do
    before do
      sign_in(current_user, :scope => :user)
    end

    let(:valid_attributes) {
      {:email => "darth@empire.gov"}
    }

    let(:invalid_attributes) {
      {:email => ""}
    }

    let(:valid_session) { {} }

    describe "GET #new" do
      it "returns a success response" do
        get :new,
            :params => {:group_id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Invitation" do
          expect {
            post :create,
                 :params => {
                   :group_id => group.to_param,
                   :invitation => valid_attributes,
                 },
                 :session => valid_session
          }.to change(Invitation, :count).by(1)
        end

        it "redirects to the created invitation" do
          post :create,
               :params => {
                 :invitation => valid_attributes,
                 :group_id => group.to_param,
               },
               :session => valid_session
          expect(response).to redirect_to(group_members_path(group))
        end
      end

      context "with invalid params" do
        it "renders the new template" do
          post :create,
               :params => {
                 :group_id => group.to_param,
                 :invitation => invalid_attributes,
               },
               :session => valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested invitation" do
        invitation = FactoryBot.create(:invitation, :group => group)
        expect {
          delete :destroy,
                 :params => {:group_id => group.to_param,
                             :id => invitation.to_param},
                 :session => valid_session
        }.to change(Invitation, :count).by(-1)
      end

      it "redirects to the invitations list" do
        invitation = FactoryBot.create(:invitation, :group => group)
        delete :destroy,
               :params => {
                 :group_id => group.to_param,
                 :id => invitation.to_param,
               },
               :session => valid_session
        expect(response).to redirect_to(group_members_path(group))
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new,
            :params => {:group_id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Invitation" do
          expect {
            post :create,
                 :params => {
                   :group_id => group.to_param,
                   :invitation => valid_attributes,
                 },
                 :session => valid_session
          }.to change(Invitation, :count).by(1)
        end

        it "redirects to the members list" do
          post :create,
               :params => {
                 :invitation => valid_attributes,
                 :group_id => group.to_param,
               },
               :session => valid_session
          expect(response).to redirect_to(group_members_path(group))
        end
      end

      context "with invalid params" do
        it "renders the new template" do
          post :create,
               :params => {
                 :group_id => group.to_param,
                 :invitation => invalid_attributes,
               },
               :session => valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested invitation" do
        invitation = FactoryBot.create(:invitation, :group => group)
        expect {
          delete :destroy,
                 :params => {:group_id => group.to_param,
                             :id => invitation.to_param},
                 :session => valid_session
        }.to change(Invitation, :count).by(-1)
      end

      it "redirects to the invitations list" do
        invitation = FactoryBot.create(:invitation, :group => group)
        delete :destroy,
               :params => {
                 :group_id => group.to_param,
                 :id => invitation.to_param,
               },
               :session => valid_session
        expect(response).to redirect_to(group_members_path(group))
      end
    end
  end
end
