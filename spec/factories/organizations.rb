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
FactoryBot.define do
  factory :organization do
    name { "MyString" }
    user { nil }
    plan { nil }
    card_number { "" }
    cvv { "" }
    expiration_date { "2021-07-26" }
  end
end
