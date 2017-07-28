require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Create new post from scratch' do
  before(:each) do
    user = create(:user_with_admin_role)
    login
  end

  it 'show New post link' do
    expect(page).to have_content 'New post'
  end

  it 'save new post without tags' do
    click_link 'New post'
    fill_in :post_title, with: 'The awesome title'
    fill_in :post_body, with: 'The awesome post'
    click_button 'Create Post'

    expect(page).to have_content 'The awesome title'
    expect(page).to have_content 'The awesome post'
  end

  it 'save new post wit tags' do
    click_link 'New post'
    fill_in :post_title, with: 'The awesome title'
    fill_in :post_body, with: 'The awesome post'
    fill_in :post_all_tags, with: 'The tag'
    click_button 'Create Post'

    expect(page).to have_content 'The awesome title'
    expect(page).to have_content 'The awesome post'
    expect(page).to have_content 'The tag'
  end
end

describe 'Post page tests when user has a post' do
  before(:each) do
    user = create(:user_with_one_post)
    login
    click_link 'Leave a comment'
  end

  it 'show post title' do
    expect(page).to have_content 'Title of the new post'
  end

  it 'show post body' do
    expect(page).to have_content 'Text of the new post'
  end

  it 'doesn\'t show comments' do
    expect(page).to have_content '0 Comments'
  end

  context 'user leave a comment' do
    before(:each) do
      fill_in :comment_body, with: 'The comment'
      click_button 'Add Comment'
    end

    it 'show comment' do
      expect(page).to have_content 'The comment'
    end

    it 'show delete link' do
      expect(page).to have_content 'Delete'
    end

    it 'show one comment' do
      expect(page).to have_content '1 Comment'
    end

    context 'user delete a comment' do
      before(:each) do
        click_link 'Delete Comment'
      end

      it 'doesn\'t show comment' do
        expect(page).not_to have_content 'The comment'
      end

      it 'show delete link' do
        expect(page).not_to have_content 'Delete'
      end

      it 'show one comment' do
        expect(page).to have_content '0 Comments'
      end
    end
  end
end