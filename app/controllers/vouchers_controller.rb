class VouchersController < ApplicationController
  def index
    @vouchers = Voucher.joins(voucher_bundle: :kit)
      .where(kits: {shop_id: Current.user.shop.id})
      .order(:id)
  end

  def create
    @kit = Kit.find(params[:kit_id])
    result = Vouchers::Assign.call(kit: @kit, attributes: voucher_params)
    if result.success?
      redirect_to @kit, notice: "Code attribué à #{result.payload.assigned_to_email}"
    else
      redirect_to @kit, alert: result.error
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit!
  end
end
