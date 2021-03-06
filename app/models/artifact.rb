# == Schema Information
#
# Table name: artifacts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_artifacts_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class Artifact < ApplicationRecord
  belongs_to :project, inverse_of: :artifacts
  has_many_attached :files

  validates :name, presence: true
end
