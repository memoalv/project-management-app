require 'system_helper'

RSpec.describe Project, type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)
  end

  scenario 'Lists created projects correctly' do
    user.organization.projects.create(title: 'System test project', details: 'details',
                                      expected_completion: '2099-11-11')

    visit projects_path

    expect(page).to have_content 'System test project'
  end

  # FIXME: test validation errors are displayed
  scenario 'Creates a project correctly' do
    visit new_project_path
    fill_in 'Title', with: 'Test project'
    fill_in 'Details', with: 'Test projects details'
    select '31', from: 'project_expected_completion_3i'
    click_on 'Create project'

    expect(page).to have_content 'The project was created successfully'
    expect(page).to have_content 'Test project'
  end

  scenario 'Deletes a project correctly' do
    user.organization.projects.create(title: 'System test project', details: 'details',
                                      expected_completion: '2099-11-11')
    visit projects_path

    accept_confirm do
      click_on 'Delete'
    end

    expect(page).to have_content 'The project was destroyed successfully'
  end

  scenario 'Edits a project correctly' do
    user.organization.projects.create(title: 'System test project', details: 'details',
                                      expected_completion: '2099-11-11')
    visit projects_path
    click_on 'Edit'

    fill_in 'Title', with: 'Modified project'
    fill_in 'Details', with: 'Modified projects details'
    click_on 'Save project'

    expect(page).to have_content 'The project was updated successfully'
    expect(page).to have_content 'Modified project'
    expect(page).to have_content 'Modified projects details'
  end
end
