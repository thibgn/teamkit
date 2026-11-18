class KitsController < ApplicationController
  def index
    @kits = Current.user.shop.kits.includes(voucher_bundle: :vouchers).order(:title)
  end

  def show
    @kit = Current.user.shop.kits.find(params[:id])
    @vouchers = @kit.voucher_bundle&.vouchers&.order(:id) || Voucher.none
    @deactivatable_count = @vouchers.deactivatable.count
  end
end
