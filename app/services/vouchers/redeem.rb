module Vouchers
  class Redeem < ApplicationService
    def initialize(shop:, code:, email:)
      @shop = shop
      @code = code.to_s.strip
      @email = email
    end

    def call
      Voucher.transaction do
        found_voucher = Voucher.lock.joins(voucher_bundle: :kit)
          .find_by(code: @code, kits: {shop_id: @shop.id})
        return failure(error: "Code inconnu") unless found_voucher
        return failure(error: "Code déjà utilisé") if found_voucher.redeemed?

        pack = found_voucher.voucher_bundle.kit
        return failure(error: "Ce pack n'est plus disponible") unless pack.published? && !pack.archived?

        found_voucher.update!(redeemed_at: Time.current)
        success(payload: Order.create!(shop: @shop, kit: pack, voucher: found_voucher, customer_email: @email, total_cents: 0))
      end
    end
  end
end
