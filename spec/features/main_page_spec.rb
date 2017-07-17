require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Main page tests for guest' do
  #that group of tests show that main page is avaliable and doesn't contain errors
  before(:each) do
    visit root_path
  end

  it 'load page' do
    expect(page).to have_content 'Main page'
  end

  it 'show sign up link' do
    expect(page).to have_content 'Sign up'
  end

  it 'not allow to sign out' do
    expect(page).not_to have_content 'Sign out'
  end

  it 'not show new post feature' do
    expect(page).not_to have_content 'New post'
  end
end

describe 'Main page tests when logged as user' do
  before(:each) do
    user = create(:user)
    login
  end

  it 'load page with link to sign out' do
    expect(page).to have_content 'Sign out'
  end

  it 'user successfully logged in' do
    expect(page).not_to have_content 'Sign in'
  end
end

describe 'Main page tests when user has a post' do
  before(:each) do
    user = create(:user_with_one_post)
    login
  end

  it 'load page with post' do
    expect(page).to have_content 'New post'
  end

  it 'load page with leave a comment link' do
    expect(page).to have_content 'Leave a comment'
  end

  it 'load page without comments' do
    expect(page).to have_content '0 Comments'
  end
end
