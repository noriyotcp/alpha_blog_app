require 'rails_helper'

RSpec.feature "ShowArticle", type: :feature do
  before do
    login
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @user)
  end

  scenario "A user shows an article" do
    visit "/"
    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(current_path).to eq article_path(@article)
  end
end
