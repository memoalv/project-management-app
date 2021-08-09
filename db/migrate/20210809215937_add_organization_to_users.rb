class AddOrganizationToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :organizations, :user, index: true, foreign_key: true
    add_reference :users, :organization, index: true, foreign_key: true
  end
end
