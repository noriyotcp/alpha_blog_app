require 'rails_helper'

RSpec.feature "ListingArticles", type: :feature do
  let!(:user) { User.create!(email: "john@example.com", password: "password") }
  let!(:article1) { Article.create(title: "The first article", body: "Body of 1st article", user: user) }
  let!(:article2) { Article.create(title: "The second article", body: "Body of 2nd article", user: user) }

  feature 'when the user does not sign in' do
    scenario "articles are shown but New Article link is not" do
      visit "/"

      expect(page).to have_content(article1.title)
      expect(page).to have_content(article1.body)
      expect(page).to have_content(article2.title)
      expect(page).to have_content(article2.body)
      expect(page).to have_link(article1.title)
      expect(page).to have_link(article2.title)
      expect(page).not_to have_link 'New Article'
    end
  end

  feature 'when the user signs in' do
    scenario "A user lists all articles" do
      login_as(user)
      visit "/"

      expect(page).to have_content(article1.title)
      expect(page).to have_content(article1.body)
      expect(page).to have_content(article2.title)
      expect(page).to have_content(article2.body)
      expect(page).to have_link(article1.title)
      expect(page).to have_link(article2.title)
    end
  end

  feature "A user has no articles" do
    scenario "Display No Articles Created" do
      Article.delete_all

      visit "/"

      expect(page).not_to have_content(article1.title)
      expect(page).not_to have_content(article1.body)
      expect(page).not_to have_content(article2.title)
      expect(page).not_to have_content(article2.body)
      expect(page).not_to have_link(article1.title)
      expect(page).not_to have_link(article2.title)

      within "h1#no-articles" do
        expect(page).to have_content "No Articles Created"
      end
    end
  end
end
