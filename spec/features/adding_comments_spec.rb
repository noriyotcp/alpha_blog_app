require 'rails_helper'

RSpec.feature "AddingComments", type: :feature do
  let(:user) { User.create!(email: "john@example.com", password: "password") }
  let(:other_user) { User.create!(email: "fred@example.com", password: "password") }

  before do
    @article = Article.create(title: "Title One", body: "Body of article one", user: user)
  end

  scenario 'permits a signed in user to write a review' do
    login_as(other_user)
    visit '/'
    click_link @article.title

    fill_in 'New Comment', with: 'An awesome article'
    click_button 'Add Comment'

    expect(page).to have_content 'Comment has been created'
    expect(page).to have_content 'An awesome article'
    expect(current_path).to eq article_path(@article.id)
  end
end
