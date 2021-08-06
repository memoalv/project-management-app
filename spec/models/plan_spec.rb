require 'rails_helper'

RSpec.describe Plan, type: :model do
  subject { build :plan, name: 'Free' }

  it { is_expected.to be_valid }

  describe 'associations' do
    it { should have_many(:organizations).inverse_of(:plan) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe '#premium?' do
    it 'Should return true if plans name is Premium' do
      premium_plan = build(:plan, name: 'Premium')

      res = premium_plan.premium?

      expect(res).to eql true
    end

    it 'Should return false if plans name is not Premium' do
      free_plan = build(:plan, name: 'free')

      res = free_plan.premium?

      expect(res).to eql false
    end
  end
end
