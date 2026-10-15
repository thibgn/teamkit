class CreateVouchers < ActiveRecord::Migration[8.1]
  def change
    create_table :vouchers do |t|
      t.references :voucher_bundle, null: false, foreign_key: true
      t.string :code
      t.string :assigned_to_email
      t.datetime :notified_at
      t.datetime :redeemed_at

      t.timestamps
    end
    add_index :vouchers, :code, unique: true
  end
end
