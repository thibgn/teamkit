class CreateVoucherBundles < ActiveRecord::Migration[8.1]
  def change
    create_table :voucher_bundles do |t|
      t.references :kit, null: false, foreign_key: true
      t.integer :expected_quantity

      t.timestamps
    end
  end
end
