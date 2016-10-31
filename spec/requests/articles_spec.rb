require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: "Title One", body: "Body of article one")
  end

  describe "GET /articles/:id" do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }

      it "handles existing article" do
        expect(response).to have_http_status(200)
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxx" }

      it "handles non-existing article" do
        expect(response).to have_http_status(302)
        flash_message = "The article you are looking for could not be found"
        expect(flash[:danger]).to eq flash_message
      end
    end
  end
end
