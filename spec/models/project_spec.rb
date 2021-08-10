require 'rails_helper'

RSpec.describe Project, type: :model do
  
  describe 'associations' do
    it { should belong_to(:organization).inverse_of(:projects) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:details) }
    it { should validate_presence_of(:expected_completion) }
  end
end
