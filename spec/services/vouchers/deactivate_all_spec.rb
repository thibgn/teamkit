require "rails_helper"

RSpec.describe Vouchers::DeactivateAll do
  let(:bundle) { create(:voucher_bundle) }
  let(:kit) { bundle.kit }

  it "deactivates only the unused codes of the pack" do
    vouchers = create_list(:voucher, 2, voucher_bundle: bundle)
    used = create(:voucher, :redeemed, voucher_bundle: bundle)
    order = create(:order, kit: kit, shop: kit.shop, voucher: used)
    other = create(:voucher)

    result = described_class.call(kit: kit)

    expect(result).to be_success
    expect(result.payload).to eq(2)
    expect(vouchers.map(&:reload)).to all(be_deactivated)
    expect(used.reload).not_to be_deactivated
    expect(Order.exists?(order.id)).to be(true)
    expect(other.reload).not_to be_deactivated
  end

  it "fails when there is no code left to deactivate" do
    create(:voucher, :redeemed, voucher_bundle: bundle)
    create(:voucher, :deactivated, voucher_bundle: bundle)

    expect(described_class.call(kit: kit).error).to eq("Aucun code à désactiver")
  end

  it "fails for a pack without codes" do
    expect(described_class.call(kit: create(:kit)).error).to eq("Aucun code à désactiver")
  end
end
