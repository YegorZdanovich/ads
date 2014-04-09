class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.text :text
      t.string :status
      t.string :type
      t.string :contact

      t.timestamps
    end
  end
end
