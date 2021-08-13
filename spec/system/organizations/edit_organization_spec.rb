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
      fill_in "Organization's name", with: 'New name'
      click_on 'Save organization'

      expect(page).to have_content 'New name'
    end

    scenario 'Changing from plan premium to free discards all but the most recent project' do
      create(:project, title: 'recent project', organization: user.organization, created_at: 1.day.ago)
      create(:project, organization: user.organization, created_at: 3.days.ago)
      create(:project, organization: user.organization, created_at: 5.days.ago)

      select 'Free', from: 'Plan'
      click_on 'Save organization'

      org_projects = user.organization.projects
      expect(org_projects.size).to eql 3
      expect(org_projects.kept.size).to eql 1
      expect(org_projects.discarded.size).to eql 2
      expect(org_projects.kept.first.title).to eql 'recent project'
    end

    scenario 'Changing from plan free to premium restores discarded projects' do
      create(:plan, name: 'Premium')
      
      create(:project, organization: user.organization, discarded_at: 3.days.ago)
      create(:project, organization: user.organization, discarded_at: 5.days.ago)

      select 'Premium', from: 'Plan'
      fill_in 'Card number', with: '4444444444444444'
      fill_in 'Cvv', with: '123'
      click_on 'Save organization'

      org_projects = user.organization.projects
      expect(org_projects.kept.size).to eql 2
      expect(org_projects.discarded.size).to eql 0
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
