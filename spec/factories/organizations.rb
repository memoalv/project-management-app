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
