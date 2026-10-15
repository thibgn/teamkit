class CreateKitVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :kit_variants do |t|
      t.references :kit, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
