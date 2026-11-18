class Voucher < ApplicationRecord
  belongs_to :voucher_bundle
  has_many :orders, dependent: :destroy

  validates :code, presence: true, uniqueness: true

  scope :assigned, -> { where.not(assigned_to_email: nil) }
  scope :redeemed, -> { where.not(redeemed_at: nil) }
  scope :unredeemed, -> { where(redeemed_at: nil) }
  scope :active, -> { where(deactivated_at: nil) }
  scope :deactivatable, -> { unredeemed.active }

  def redeemed? = redeemed_at.present?

  def deactivated? = deactivated_at.present?
end
