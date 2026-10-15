require "rails_helper"

RSpec.describe Vouchers::Redeem do
  def redeem(voucher, shop: voucher.voucher_bundle.kit.shop, email: "parent@example.test")
    described_class.call(shop: shop, code: voucher.code, email: email)
  end

  it "creates a free order and marks the code as used" do
    voucher = create(:voucher)

    result = redeem(voucher)

    expect(result).to be_success
    expect(result.payload).to have_attributes(total_cents: 0, kit: voucher.voucher_bundle.kit, customer_email: "parent@example.test")
    expect(voucher.reload).to be_redeemed
  end

  it "refuses a code already used" do
    expect(redeem(create(:voucher, :redeemed)).error).to eq("Code déjà utilisé")
  end

  it "refuses a code of another club" do
    voucher = create(:voucher)

    expect(redeem(voucher, shop: create(:shop)).error).to eq("Code inconnu")
  end

  it "refuses a code of an archived pack" do
    voucher = create(:voucher, voucher_bundle: create(:voucher_bundle, kit: create(:kit, :archived)))

    expect(redeem(voucher).error).to eq("Ce pack n'est plus disponible")
  end
end
