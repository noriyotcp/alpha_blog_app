require 'rails_helper'

RSpec.feature "ShowArticle", type: :feature do
  let!(:user) { User.create!(email: "john@example.com", password: "password") }
  let(:other_user) { User.create!(email: "fred@example.com", password: "password") }
  let!(:article) { Article.create(title: "The first article", body: "Body of 1st article", user: user) }

  scenario 'to non-signed in user, hide the Edit and Delete buttons' do
    visit "/"
    click_link article.title

    expect(page).to have_content article.title
    expect(page).to have_content article.body
    expect(current_path).to eq article_path(article)

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')

  end

  scenario 'to non-owner, hide the Edit and Delete buttons' do
    login_as(other_user)
    visit "/"
    click_link article.title

    expect(page).to have_content article.title
    expect(page).to have_content article.body
    expect(current_path).to eq article_path(article)

    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')

  end

  scenario "A signed in owner sees an article and both the Edit and Delete buttons" do
    login_as(user)
    visit "/"
    click_link article.title

    expect(page).to have_content article.title
    expect(page).to have_content article.body
    expect(current_path).to eq article_path(article)

    expect(page).to have_link 'Edit Article'
    expect(page).to have_link 'Delete Article'
  end
end
