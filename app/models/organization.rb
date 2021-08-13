# == Schema Information
#
# Table name: organizations
#
#  id              :bigint           not null, primary key
#  card_number     :string
#  cvv             :string
#  expiration_date :date
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_id         :bigint           not null
#
# Indexes
#
#  index_organizations_on_plan_id  (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
class Organization < ApplicationRecord
  has_many :users, inverse_of: :organization
  belongs_to :plan, inverse_of: :organizations
  has_many :projects, inverse_of: :organization

  validates :name, presence: true, uniqueness: true

  with_options if: :premium_plan? do |model|
    model.validates :card_number,
                    presence: true,
                    format: { with: /([0-9]{16})/, message: 'must contain only numbers' },
                    length: { is: 16 }
    model.validates :cvv,
                    presence: true,
                    format: { with: /([0-9]{3})/, message: 'must contain only numbers' },
                    length: { is: 3 }
    model.validates :expiration_date,
                    presence: true,
                    format: { with: /([0-9]{4}-[01][0-9]-[0-3][0-9])/, message: 'Invalid date format' }
  end

  # FIXME: hacky solution?
  def premium_plan?
    if !plan.nil?
      plan.premium?
    else
      false
    end
  end

  def discard_old_projects
    most_recent_project = projects.by_created.first

    projects.where.not(id: most_recent_project.id).discard_all! unless most_recent_project.nil?
  end

  def restore_projects
    projects.undiscard_all!
  end
end
