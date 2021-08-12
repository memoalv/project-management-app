# == Schema Information
#
# Table name: projects
#
#  id                  :bigint           not null, primary key
#  details             :text
#  discarded_at        :datetime
#  expected_completion :date
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organization_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_discarded_at     (discarded_at)
#  index_projects_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Project < ApplicationRecord
  include Discard::Model
  
  belongs_to :organization, inverse_of: :projects

  validates :title, presence: true
  validates :details, presence: true
  validates :expected_completion, presence: true
end
