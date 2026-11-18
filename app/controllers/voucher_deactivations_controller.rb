class VoucherDeactivationsController < ApplicationController
  def create
    kit = Current.user.shop.kits.find(params[:kit_id])
    result = Vouchers::DeactivateAll.call(kit: kit)

    if result.success?
      count = result.payload
      redirect_to kit, notice: "#{count} #{count > 1 ? "codes désactivés" : "code désactivé"}."
    else
      redirect_to kit, alert: result.error
    end
  end
end
