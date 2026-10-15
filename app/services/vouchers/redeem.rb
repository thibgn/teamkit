module Vouchers
  class Redeem < ApplicationService
    def initialize(shop:, code:, email:)
      @shop = shop
      @code = code.to_s.strip
      @email = email
    end

    def call
      Voucher.transaction do
        voucher = Voucher.lock.joins(voucher_bundle: :kit)
          .find_by(code: @code, kits: {shop_id: @shop.id})
        return failure(error: "Code inconnu") unless voucher
        return failure(error: "Code déjà utilisé") if voucher.redeemed?

        kit = voucher.voucher_bundle.kit
        return failure(error: "Ce pack n'est plus disponible") unless kit.published? && !kit.archived?

        voucher.update!(redeemed_at: Time.current)
        success(payload: Order.create!(shop: @shop, kit: kit, voucher: voucher, customer_email: @email, total_cents: 0))
      end
    end
  end
end
