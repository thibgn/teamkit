class AddDeactivatedAtToVouchers < ActiveRecord::Migration[8.1]
  def change
    add_column :vouchers, :deactivated_at, :datetime
  end
end
