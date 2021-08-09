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
FactoryBot.define do
  factory :organization do
    name { 'MyString' }
    plan { nil }
    card_number { '' }
    cvv { '' }
    expiration_date { '2021-07-26' }
  end
end
