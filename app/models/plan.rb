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
  has_many :organizations

  validates :name, presence: true, uniqueness: true

  def premium?
    name == 'Premium'
  end
end
