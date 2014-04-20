class AddPriceToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :price, :integer
  end
end
