class RemoveRoleFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :role, :string
  end
end
