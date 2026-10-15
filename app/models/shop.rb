class Shop < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :products, dependent: :destroy
  has_many :kits, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
end
