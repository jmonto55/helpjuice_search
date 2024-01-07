# spec/controllers/articles_controller_spec.rb

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:article) { Article.create(title: "Sample Title", author: "Sample Author", content: "Sample Content" * 5) }

    it "returns a success response" do
      get :show, params: { id: article.id }
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
    let(:article) { Article.create(title: "Sample Title", author: "Sample Author", content: "Sample Content" * 5) }

    it "returns a success response" do
      get :edit, params: { id: article.id }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new article" do
        expect {
          post :create, params: { article: { title: "Sample Title", author: "Sample Author", content: "Sample Content" * 5 } }
        }.to change(Article, :count).by(1)

        expect(response).to redirect_to(article_url(Article.last))
      end
    end
  end

  describe "PATCH #update" do
    let(:article) { Article.create(title: "Sample Title", author: "Sample Author", content: "Sample Content" * 5) }

    context "with valid parameters" do
      it "updates the requested article" do
        patch :update, params: { id: article.id, article: { title: "New Title" } }
        expect(article.reload.title).to eq("New Title")
        expect(response).to redirect_to(article_url(article))
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:article) { Article.create(title: "Sample Title", author: "Sample Author", content: "Sample Content" * 5) }

    it "destroys the requested article" do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)

      expect(response).to redirect_to(articles_url)
    end
  end
end
