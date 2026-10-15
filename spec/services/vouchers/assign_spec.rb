require "rails_helper"

RSpec.describe Vouchers::Assign do
  it "assigns a free code to the member and sends the email" do
    kit = create(:kit)
    bundle = create(:voucher_bundle, kit: kit)
    voucher = create(:voucher, voucher_bundle: bundle)
    mail = double(deliver_now: true)
    allow(VoucherMailer).to receive_message_chain(:with, :assignment).and_return(mail)

    result = described_class.call(kit: kit, attributes: {assigned_to_email: "parent@example.test"})

    expect(result).to be_success
    expect(voucher.reload.assigned_to_email).to eq("parent@example.test")
    expect(mail).to have_received(:deliver_now)
  end
end
