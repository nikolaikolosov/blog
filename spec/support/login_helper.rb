def login(email = 'test@test.ru', password = 'testtesttest')
  visit root_path
  first(:link, 'Sign in').click
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button 'Log in'
end