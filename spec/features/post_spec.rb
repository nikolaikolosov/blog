require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Post page tests when user has a post' do
  before(:each) do
    user = create(:user_with_one_post)
    login
    click_link 'Leave a comment'
  end

  it 'show post title' do
    expect(page).to have_content 'New post'
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