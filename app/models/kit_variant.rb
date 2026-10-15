class KitVariant < ApplicationRecord
  belongs_to :kit
  belongs_to :variant

  validates :variant_id, uniqueness: {scope: :kit_id}
end
