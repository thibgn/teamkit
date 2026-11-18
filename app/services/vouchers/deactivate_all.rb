module Vouchers
  class DeactivateAll < ApplicationService
    def initialize(kit:)
      @kit = kit
    end

    def call
      vouchers = @kit.voucher_bundle&.vouchers
      return failure(error: "Aucun code à désactiver") unless vouchers

      now = Time.current
      count = vouchers.deactivatable.update_all(deactivated_at: now, updated_at: now)
      return failure(error: "Aucun code à désactiver") if count.zero?

      success(payload: count)
    end
  end
end
