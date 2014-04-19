class RenameTypeColumnInAdvertisements < ActiveRecord::Migration
  def change
    rename_column :advertisements, :type, :category
  end
end
