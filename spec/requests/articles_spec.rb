require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) { User.create(email: "john@example.com", password: "password") }
  let(:other_user) { User.create(email: "fred@example.com", password: "password") }

  before do
    @article = Article.create(title: "Title One", body: "Body of article one", user: user)
  end

  describe 'GET /articles/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }

      it 'redirects to the signin page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(other_user)
        get "/articles/#{@article.id}/edit"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only edit your own article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful edit' do
      before do
        login_as(user)
        get "/articles/#{@article.id}/edit"
      end

      it 'successfully edits article' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE /articles/:id/' do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }

      it 'redirects to the signin page' do
        expect(response.status).to eq 302
        flash_message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is non-owner' do
      before do
        login_as(other_user)
        delete "/articles/#{@article.id}"
      end

      it 'redirects to the home page' do
        expect(response.status).to eq 302
        flash_message = 'You can only delete your own article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user as owner successful delete' do
      before do
        login_as(user)
        delete "/articles/#{@article.id}"
      end

      it 'successfully delete article' do
        expect(response.status).to eq 302
        expect(flash[:success]).to eq "Article has been deleted"
      end
    end
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
