require 'system_helper'

RSpec.describe 'Destroy Project', type: :system do
  let(:user) { create(:admin) }

  before(:each) do
    sign_in(user)
  end
  
  scenario 'Destroys a project correctly' do
    user.organization.projects.create(title: 'System test project', details: 'details',
                                      expected_completion: '2099-11-11')
    visit projects_path

    accept_confirm do
      click_on 'Delete'
    end

    expect(page).to have_content 'The project was destroyed successfully'
  end
end
