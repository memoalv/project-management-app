require 'system_helper'

RSpec.describe 'Show project', type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)
  end

  scenario "Shows a project's data correctly" do
    user.organization.projects.create(title: 'System test project', details: 'Test project details',
                                      expected_completion: '2099-11-11')
    visit projects_path
    click_on 'System test project'

    expect(page).to have_content 'System test project'
    expect(page).to have_content 'Test project details'
    expect(page).to have_content '2099-11-11'
  end
end
