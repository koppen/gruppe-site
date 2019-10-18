require "rails_helper"

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, :type => :controller do
  let(:valid_attributes) {
<% if defined?(FactoryBot) -%>
    FactoryBot.attributes_for(:<%= file_name %>)
<% else -%>
    skip("Add a hash of attributes valid for your model")
<% end -%>
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

<% unless options[:singleton] -%>
  describe "GET #index" do
    it "returns a success response" do
      <%= class_name %>.create! valid_attributes
      get :index, :params => {}, :session => valid_session
      expect(response).to be_successful
    end
  end

<% end -%>
  describe "GET #show" do
    it "returns a success response" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :show,
        :params => {:id => <%= file_name %>.to_param},
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
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :edit,
        :params => {:id => <%= file_name %>.to_param},
        :session => valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new <%= class_name %>" do
        expect {
          post :create,
            :params => {:<%= ns_file_name %> => valid_attributes},
            :session => valid_session
        }.to change(<%= class_name %>, :count).by(1)
      end

      it "redirects to the created <%= ns_file_name %>" do
        post :create,
          :params => {:<%= ns_file_name %> => valid_attributes},
          :session => valid_session
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    context "with invalid params" do
      it "renders the new template" do
        post :create,
          :params => {:<%= ns_file_name %> => invalid_attributes},
          :session => valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update,
          :params => {
            :id => <%= file_name %>.to_param,
            :<%= ns_file_name %> => new_attributes
          },
          :session => valid_session
        <%= file_name %>.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update,
          :params => {
            :id => <%= file_name %>.to_param,
            :<%= ns_file_name %> => valid_attributes
          },
          :session => valid_session
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update,
          :params => {
            :id => <%= file_name %>.to_param,
            :<%= ns_file_name %> => invalid_attributes
          },
          :session => valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      expect {
        delete :destroy,
          :params => {:id => <%= file_name %>.to_param},
          :session => valid_session
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it "redirects to the <%= table_name %> list" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      delete :destroy,
        :params => {:id => <%= file_name %>.to_param},
        :session => valid_session
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end
end
<% end -%>
