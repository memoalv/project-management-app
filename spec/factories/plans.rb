# == Schema Information
#
# Table name: plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :plan do
    name { 'MyString' }
  end
end
