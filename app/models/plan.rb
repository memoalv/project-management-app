# == Schema Information
#
# Table name: plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Plan < ApplicationRecord
  has_many :organizations, inverse_of: :plan

  validates :name, presence: true, uniqueness: true

  scope :default_plan, -> { find_by name: 'Free' }

  def premium?
    name == 'Premium'
  end
end
