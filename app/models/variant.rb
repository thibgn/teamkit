class Variant < ApplicationRecord
  belongs_to :product
  has_many :kit_variants, dependent: :destroy

  validates :size, presence: true
  validates :price_cents, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
