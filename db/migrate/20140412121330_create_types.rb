class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :value

      t.timestamps
    end
  end
end
