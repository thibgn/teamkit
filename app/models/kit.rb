class Kit < ApplicationRecord
  belongs_to :shop
  has_many :kit_variants, dependent: :destroy
  has_many :variants, through: :kit_variants
  has_one :voucher_bundle, dependent: :destroy
  has_many :orders, dependent: :restrict_with_error

  validates :title, presence: true
  validates :price_cents, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  scope :published, -> { where.not(published_at: nil) }

  def published? = published_at.present?

  def archived? = archived_at.present?
end
