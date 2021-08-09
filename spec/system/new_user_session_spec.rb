require 'system_helper'

RSpec.describe 'New user session', type: :system do
  let(:user) { create(:admin) }

  context 'with correct credentials' do
    scenario 'should be successful' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'crazy_pwd'
      click_on 'Log in'

      expect(page).to have_content('Sign out')
    end
  end

  context 'with incorrect credentials' do
    scenario 'should be unsuccessful' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_on 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
