require 'rails_helper'

RSpec.describe Artifact, type: :model do
  describe 'associations' do
    it { should belong_to(:project).inverse_of(:artifacts) }
    it { should have_many_attached(:files) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
