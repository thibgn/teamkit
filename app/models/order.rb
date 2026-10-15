class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :kit
  belongs_to :voucher, optional: true

  normalizes :customer_email, with: ->(e) { e.strip.downcase }
  validates :customer_email, presence: true
end
