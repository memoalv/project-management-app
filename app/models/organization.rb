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
  belongs_to :user
  belongs_to :plan

  validates :name, presence: true, uniqueness: true
end
