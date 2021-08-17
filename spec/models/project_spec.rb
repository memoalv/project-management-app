require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:organization) { create(:organization, name: 'Icalia') }

  describe 'associations' do
    it { should belong_to(:organization).inverse_of(:projects) }
    it { should have_many(:artifacts).inverse_of(:project) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:details) }
    it { should validate_presence_of(:expected_completion) }
  end

  describe 'scopes' do
    describe 'by_created' do
      it 'orders projects by latest created' do
        project1 = create(:project, organization: organization)
        project1.created_at = 2.days.ago
        project1.save

        project2 = create(:project, organization: organization)
        project2.created_at = 1.day.ago
        project2.save

        project3 = create(:project, organization: organization)
        project3.created_at = 5.days.ago
        project3.save

        res = Project.by_created.pluck(:id)

        expect(res).to eql [project2.id, project1.id, project3.id]
      end
    end
  end
end
