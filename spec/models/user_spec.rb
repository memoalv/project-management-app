require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:admin) }

  it { should accept_nested_attributes_for(:organization) }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'associations' do
    it { should have_one(:organization).dependent(:destroy) }
  end
end
