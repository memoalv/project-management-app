require 'system_helper'

RSpec.describe 'Edit organization', type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)

    find('.feather.feather-more-vertical').click
    click_on 'Edit organization'
  end

  context 'with valid input' do
    scenario 'Edits an organization correctly' do
      fill_in "Organization's name", with: 'Modified orgs name'
      click_on 'Save organization'

      expect(page).to have_content 'Modified orgs name'
    end
  end

  context 'with invalid input' do
    scenario 'Shows validation errors' do
      fill_in "Organization's name", with: ''
      click_on 'Save organization'

      expect(page).to have_content "Name can't be blank"
    end
  end

  context 'form interaction' do
    scenario 'Hides card fields for free plan' do
      select 'Free', from: 'Plan'

      expect(page).to_not have_content('Card number')
      expect(page).to_not have_content('Cvv')
      expect(page).to_not have_content('Expiration date')
    end

    scenario 'Shows card fields for premium plan' do
      create(:plan, name: 'Premium')
      
      select 'Premium', from: 'Plan'

      expect(page).to have_content('Card number')
      expect(page).to have_content('Cvv')
      expect(page).to have_content('Expiration date')
    end
  end
end
