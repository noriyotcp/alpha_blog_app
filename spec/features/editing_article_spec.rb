require 'rails_helper'

RSpec.feature "EditingArticle", type: :feature do
  before do
    login
    @article = Article.create(title: "Title One", body: "Body of article one", user: @user)
  end

  scenario "A user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body of article"
    click_button "Update Article"

    expect(page).to have_content "Article has been updated"
    expect(page.current_path).to eq article_path(@article)
  end

  scenario "A user fails to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content "Article has not been updated"
    expect(page.current_path).to eq article_path(@article)
  end
end
