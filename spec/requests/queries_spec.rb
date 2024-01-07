# spec/controllers/queries_controller_spec.rb

require 'rails_helper'

RSpec.describe QueriesController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:query) { Query.create(user_ip: "127.0.0.1", search: "Sample Search") }

    it "returns a success response" do
      get :show, params: { id: query.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    let(:query) { Query.create(user_ip: "127.0.0.1", search: "Sample Search") }

    it "returns a success response" do
      get :edit, params: { id: query.id }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new query" do
        expect {
          post :create, params: { query: { user_ip: "127.0.0.1", search: "Sample Search" } }
        }.to change(Query, :count).by(1)

        expect(response).to redirect_to(query_url(Query.last))
      end
    end
  end

  describe "PATCH #update" do
    let(:query) { Query.create(user_ip: "127.0.0.1", search: "Sample Search") }

    context "with valid parameters" do
      it "updates the requested query" do
        patch :update, params: { id: query.id, query: { search: "New Search" } }
        expect(query.reload.search).to eq("New Search")
        expect(response).to redirect_to(query_url(query))
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:query) { Query.create(user_ip: "127.0.0.1", search: "Sample Search") }

    it "destroys the requested query" do
      expect {
        delete :destroy, params: { id: query.id }
      }.to change(Query, :count).by(-1)

      expect(response).to redirect_to(queries_url)
    end
  end
end
