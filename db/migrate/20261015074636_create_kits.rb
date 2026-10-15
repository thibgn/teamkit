class CreateKits < ActiveRecord::Migration[8.1]
  def change
    create_table :kits do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :title
      t.integer :price_cents
      t.datetime :published_at
      t.datetime :archived_at

      t.timestamps
    end
  end
end
