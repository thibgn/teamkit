module Vouchers
  class Assign < ApplicationService
    def initialize(kit:, attributes:)
      @kit = kit
      @attributes = attributes
    end

    def call
      bundle = @kit.voucher_bundle
      return failure(error: "Ce pack n'a pas de codes") unless bundle

      Voucher.transaction do
        if bundle.assigned_count <= bundle.expected_quantity
          voucher = bundle.vouchers.where(assigned_to_email: nil).order(:id).first
          voucher ||= bundle.vouchers.create!(code: "#{@kit.id}-#{rand(1000..9999)}")
          voucher.update!(@attributes.merge(notified_at: Time.current))
          VoucherMailer.with(voucher: voucher).assignment.deliver_now
          success(payload: voucher)
        else
          failure(error: "Tous les codes de ce pack sont attribués")
        end
      end
    end
  end
end
