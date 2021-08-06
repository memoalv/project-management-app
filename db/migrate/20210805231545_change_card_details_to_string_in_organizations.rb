class ChangeCardDetailsToStringInOrganizations < ActiveRecord::Migration[6.1]
  def change
    change_column :organizations, :card_number, :string
    change_column :organizations, :cvv, :string
  end
end
