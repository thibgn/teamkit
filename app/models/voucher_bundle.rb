class VoucherBundle < ApplicationRecord
  belongs_to :kit
  has_many :vouchers, dependent: :destroy

  validates :expected_quantity, numericality: {only_integer: true, greater_than: 0}

  def assigned_count = vouchers.where.not(assigned_to_email: nil).count
end
