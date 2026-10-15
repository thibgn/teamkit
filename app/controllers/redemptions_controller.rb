class RedemptionsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_shop

  def new
  end

  def create
    result = Vouchers::Redeem.call(shop: @shop, code: params[:code], email: params[:email])
    if result.success?
      redirect_to new_redemption_path(@shop.slug), notice: "Merci, votre commande est enregistrée."
    else
      flash.now[:alert] = result.error
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_shop
    @shop = Shop.find_by!(slug: params[:shop_slug])
  end
end
