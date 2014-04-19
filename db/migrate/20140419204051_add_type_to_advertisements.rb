class AddTypeToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :type, :string
  end
end
