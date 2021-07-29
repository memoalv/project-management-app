class Organization < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :name, presence: true, uniqueness: true
end
