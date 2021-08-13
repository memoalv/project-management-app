require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:premium_plan) { create(:plan, name: 'Premium') }
  let(:free_plan) { create(:plan, name: 'Free') }
  let(:organization) { create(:organization, name: 'Icalia') }

  subject { build(:organization, plan_id: free_plan.id) }

  it { is_expected.to be_valid }

  describe 'associations' do
    it { should belong_to(:plan).inverse_of(:organizations) }
    it { should have_many(:users).inverse_of(:organization) }
    it { should have_many(:projects).inverse_of(:organization) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'Premium plan' do
      subject do
        build(:organization,
              plan_id: premium_plan.id)
      end

      it { should validate_presence_of(:card_number) }
      it { should validate_presence_of(:cvv) }
      it { should validate_presence_of(:expiration_date) }

      it { should allow_value('1234123412341234').for(:card_number) }
      it { should_not allow_value('123123').for(:card_number) }
      it { should_not allow_value('123412341234123456').for(:card_number) }
      it { should_not allow_value('123ab23412341234').for(:card_number) }
      it { should_not allow_value('ab').for(:card_number) }

      it { should allow_value('123').for(:cvv) }
      it { should_not allow_value('1234').for(:cvv) }
      it { should_not allow_value('abc').for(:cvv) }
      it { should_not allow_value('a1c').for(:cvv) }
    end

    context 'Free plan' do
      it { should_not validate_presence_of(:card_number) }
      it { should_not validate_presence_of(:cvv) }
      it { should_not validate_presence_of(:expiration_date) }
    end
  end

  describe '#discard_old_projects' do
    before(:each) do
      project1 = create(:project, organization: organization)
      project1.created_at = 2.days.ago
      project1.save

      project2 = create(:project, title: 'recent_project', organization: organization)
      project2.created_at = 1.day.ago
      project2.save

      project3 = create(:project, organization: organization)
      project3.created_at = 5.days.ago
      project3.save
    end

    it 'discards all but one project for the organization' do
      organization.discard_old_projects

      expect(organization.projects.size).to eql 3
      expect(organization.projects.kept.size).to eql 1
      expect(organization.projects.discarded.size).to eql 2
    end

    it 'only most recent project should be kept' do
      organization.discard_old_projects

      kept_project = organization.projects.kept.first
      expect(kept_project.title).to eql 'recent_project'
    end
  end
end
