require "rails_helper"

RSpec.describe VoucherBundle do
  it "counts only the vouchers assigned to a member" do
    bundle = create(:voucher_bundle)
    create(:voucher, :assigned, voucher_bundle: bundle)
    create(:voucher, voucher_bundle: bundle)

    expect(bundle.assigned_count).to eq(1)
  end
end
