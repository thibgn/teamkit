class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :kit, null: false, foreign_key: true
      t.references :voucher, null: false, foreign_key: true
      t.string :customer_email
      t.integer :total_cents

      t.timestamps
    end
  end
end
