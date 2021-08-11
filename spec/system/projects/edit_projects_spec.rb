require 'system_helper'

RSpec.describe 'Edit project', type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)
    
    user.organization.projects.create(title: 'System test project', details: 'details',
                                      expected_completion: '2099-11-11')
    visit projects_path
    click_on 'Edit'
  end

  context 'with valid input' do
    scenario 'Edits a project correctly' do
      fill_in 'Title', with: 'Modified project'
      fill_in 'Details', with: 'Modified projects details'
      click_on 'Save project'

      expect(page).to have_content 'The project was updated successfully'
      expect(page).to have_content 'Modified project'
      expect(page).to have_content 'Modified projects details'
    end
  end

  context 'with invalid input' do
    scenario 'Shows validation errors' do
      fill_in 'Title', with: ''
      fill_in 'Details', with: ''
      click_on 'Save project'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Details can't be blank"
    end
  end
end
