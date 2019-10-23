# frozen_string_literal: true

require "rails_helper"

RSpec.describe MembersController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:group) { FactoryBot.create(:group) }
  let(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    {
      :user_id => user.to_param,
    }
  }

  let(:invalid_attributes) {
    {
      :group_id => 0,
      :user_id => 0,
    }
  }

  let(:valid_session) { {} }

  context "when logged in" do
    let(:current_user) { FactoryBot.create(:user) }

    before do
      sign_in(current_user, :scope => :user)
    end

    describe "GET #index" do
      it "returns a success response" do
        # Member.create! valid_attributes
        get :index,
            :params => {:group_id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      before do
        sign_in(current_user, :scope => user)
      end

      context "with valid params" do
        it "creates a new Member" do
          expect {
            post :create,
                 :params => {
                   :group_id => group.to_param,
                   :user_id => user.to_param,
                 },
                 :session => valid_session
          }.to change(Member, :count).by(1)
        end

        it "creates a new Membership" do
          expect {
            post :create,
                 :params => {
                   :group_id => group.to_param,
                   :user_id => user.to_param,
                 },
                 :session => valid_session
          }.to change(Membership, :count).by(1)
        end

        it "redirects to the members list" do
          post :create,
               :params => {
                 :group_id => group.to_param,
                 :user_id => user.to_param,
               },
               :session => valid_session
          expect(response).to redirect_to(group_members_path(group))
        end
      end

      context "with invalid params" do
        it "raises an error" do
          expect {
            post :create,
                 :params => {
                   :group_id => group.to_param,
                   :member => invalid_attributes,
                 },
                 :session => valid_session
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested member" do
        member = Member.create! valid_attributes
        expect {
          delete :destroy,
                 :params => {
                   :group_id => group.to_param,
                   :id => member.to_param,
                 },
                 :session => valid_session
        }.to change(Member, :count).by(-1)
      end

      it "removes the member from the group" do
        membership = FactoryBot.create(:membership, :group => group)
        expect {
          delete :destroy,
                 :params => {
                   :group_id => group.to_param,
                   :id => membership.member.to_param,
                 },
                 :session => valid_session
        }.to change {
          group.members.count
        }.by(-1)
      end

      it "redirects to the members list" do
        member = Member.create! valid_attributes
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
