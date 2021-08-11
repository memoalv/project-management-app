require 'system_helper'

RSpec.describe 'Create new project', type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)
  end

  context 'with valid input' do
    scenario 'Creates a project correctly' do
      visit new_project_path
      fill_in 'Title', with: 'Test project'
      fill_in 'Details', with: 'Test projects details'
      select '31', from: 'project_expected_completion_3i'
      click_on 'Create project'

      expect(page).to have_content 'The project was created successfully'
      expect(page).to have_content 'Test project'
    end
  end

  context 'with invalid input' do
    scenario 'Shows validation errors' do
      visit new_project_path
      click_on 'Create project'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Details can't be blank"
    end
  end
end
