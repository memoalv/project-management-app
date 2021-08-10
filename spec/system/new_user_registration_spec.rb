require 'system_helper'

RSpec.describe 'New user registration', type: :system do
  before(:each) do
    create(:plan, name: 'Premium')
    create(:plan, name: 'Free')
  end

  scenario 'The user should be able to register correctly' do
    visit new_user_registration_path
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'crazy_pwd'
    fill_in 'Password confirmation', with: 'crazy_pwd'
    fill_in 'Organization', with: 'My first org'
    click_on 'Sign up'

    expect(page).to have_content('Sign out')
  end

  scenario 'Newly registered user should be an Admin' do
    visit new_user_registration_path
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'crazy_pwd'
    fill_in 'Password confirmation', with: 'crazy_pwd'
    fill_in 'Organization', with: 'My first org'
    click_on 'Sign up'

    registed_user = User.last

    expect(page).to have_content('Sign out')
    expect(registed_user.type).to eql 'Admin'
  end

  context 'Validation errors should be displayed' do
    scenario 'Invalid email HTML5 validation msg' do
      visit new_user_registration_path
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'crazy_pwd'
      fill_in 'Password confirmation', with: 'crazy_pwd'
      fill_in 'Organization', with: 'My first org'
      click_on 'Sign up'

      invalid_email_field = page.find(:field, 'Email',
                                      validation_message: "Please include an '@' in the email address. 'email' is missing an '@'.")

      expect(invalid_email_field).to_not eql nil
    end

    scenario 'Blank field errors are displayed' do
      visit new_user_registration_path
      click_on 'Sign up'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Organization name can't be blank")
    end

    scenario 'Blank field errors are displayed' do
      visit new_user_registration_path
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: 'crazy_pwd'
      fill_in 'Password confirmation', with: 'crazy_pwd'
      fill_in 'Organization', with: 'My first org'
      select 'Premium', from: 'Plan'
      click_on 'Sign up'

      expect(page).to have_content("Organization card number can't be blank")
      expect(page).to have_content('Organization card number must contain only numbers')
      expect(page).to have_content('Organization card number is the wrong length (should be 16 characters)')
      expect(page).to have_content("Organization cvv can't be blank")
      expect(page).to have_content('Organization cvv must contain only numbers')
      expect(page).to have_content('Organization cvv is the wrong length (should be 3 characters)')
    end
  end
end
