require 'system_helper'

RSpec.describe 'Projects index', type: :system do
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
end
