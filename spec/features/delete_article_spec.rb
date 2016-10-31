require 'rails_helper'

RSpec.feature "DeleteArticle", type: :feature do
  before do
    @article = Article.create(title: "Title One", body: "Body of article one")
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content "Article has been deleted"
    expect(current_path).to eq articles_path

    visit article_path(@article)
    flash_message = "The article you are looking for could not be found"
    expect(page).to have_content flash_message
  end
end
