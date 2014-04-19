class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :advertisements, :type_id, :category_id
  end
end
