# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin_#{n}@test.com" }
    password { 'crazy_pwd' }
    type { 'Admin' }
  end

  factory :member do
    sequence(:email) { |n| "member_#{n}@test.com" }
    password { 'crazy_pwd' }
    type { 'Member' }
  end
end
