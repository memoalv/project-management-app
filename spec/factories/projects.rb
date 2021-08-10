# == Schema Information
#
# Table name: projects
#
#  id                  :bigint           not null, primary key
#  details             :text
#  expected_completion :date
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organization_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
FactoryBot.define do
  factory :project do
    association :organization
    title { "My important project" }
    details { "Super details" }
    expected_completion { "2021-08-06" }
  end
end
