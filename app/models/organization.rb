# == Schema Information
#
# Table name: organizations
#
#  id              :bigint           not null, primary key
#  card_number     :integer
#  cvv             :integer
#  expiration_date :date
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  plan_id         :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_organizations_on_plan_id  (plan_id)
#  index_organizations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (user_id => users.id)
#
class Organization < ApplicationRecord
  belongs_to :user, inverse_of: :organization
  belongs_to :plan, inverse_of: :organizations

  validates :name, presence: true, uniqueness: true

  with_options if: :premium_plan? do |model|
    model.validates :card_number,
                    presence: true,
                    format: { with: /([0-9])+/, message: 'Field must contain only numbers' },
                    length: { is: 16 }
    model.validates :cvv,
                    presence: true,
                    format: { with: /([0-9])+/, message: 'Field must contain only numbers' },
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
end
