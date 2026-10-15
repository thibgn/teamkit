class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :shops, :slug, unique: true
  end
end
