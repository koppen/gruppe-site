# frozen_string_literal: true

require "rails_helper"

RSpec.describe GroupsController, :type => :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) {
    FactoryBot.attributes_for(:group)
  }

  let(:invalid_attributes) {
    {:name => ""}
  }

  let(:valid_session) { {} }

  context "when logged in" do
    let(:current_user) { FactoryBot.create(:user) }

    before do
      sign_in(current_user, :scope => :user)
    end

    describe "GET #index" do
      it "returns a success response" do
        Group.create! valid_attributes
        get :index, :params => {}, :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        group = Group.create! valid_attributes
        get :show,
            :params => {:id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, :params => {}, :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "returns a success response" do
        group = Group.create! valid_attributes
        get :edit,
            :params => {:id => group.to_param},
            :session => valid_session
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Group" do
          expect {
            post :create,
                 :params => {:group => valid_attributes},
                 :session => valid_session
          }.to change(Group, :count).by(1)
        end

        it "redirects to the created group" do
          post :create,
               :params => {:group => valid_attributes},
               :session => valid_session
          expect(response).to redirect_to(Group.last)
        end

        it "uses the CreateGroup operation" do
          expect_any_instance_of(CreateGroup).to \
            receive(:process).
            and_call_original
          post :create,
               :params => {:group => valid_attributes},
               :session => valid_session
        end
      end

      context "with invalid params" do
        it "renders the new template" do
          post :create,
               :params => {:group => invalid_attributes},
               :session => valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {:name => "Association of Evilness"}
        }

        it "updates the requested group" do
          group = Group.create! valid_attributes
          put :update,
              :params => {
                :id => group.to_param,
                :group => new_attributes,
              },
              :session => valid_session
          group.reload
          expect(group.name).to eq("Association of Evilness")
        end

        it "redirects to the group" do
          group = Group.create! valid_attributes
          put :update,
              :params => {
                :id => group.to_param,
                :group => valid_attributes,
              },
              :session => valid_session
          expect(response).to redirect_to(group)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          group = Group.create! valid_attributes
          put :update,
              :params => {
                :id => group.to_param,
                :group => invalid_attributes,
              },
              :session => valid_session
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested group" do
        group = Group.create! valid_attributes
        expect {
          delete :destroy,
                 :params => {:id => group.to_param},
                 :session => valid_session
        }.to change(Group, :count).by(-1)
      end

      it "redirects to the groups list" do
        group = Group.create! valid_attributes
        delete :destroy,
               :params => {:id => group.to_param},
               :session => valid_session
        expect(response).to redirect_to(groups_url)
      end
    end
  end
end
