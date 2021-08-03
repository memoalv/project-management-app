require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:admin) { create(:admin) }
  let(:premium_plan) { create(:plan, name: 'Premium') }
  let(:free_plan) { create(:plan, name: 'Free') }
  subject { build(:organization, user_id: admin.id, plan_id: free_plan.id) }

  it { is_expected.to be_valid }

  describe 'associations' do
    it { should belong_to(:plan) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'Premium plan' do
      subject do
        build(:organization,
              user_id: admin.id,
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
    end

    context 'Free plan' do
      it { should_not validate_presence_of(:card_number) }
      it { should_not validate_presence_of(:cvv) }
      it { should_not validate_presence_of(:expiration_date) }
    end
  end
end
