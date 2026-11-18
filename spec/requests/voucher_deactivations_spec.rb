require "rails_helper"

RSpec.describe "Voucher deactivations" do
  let(:user) { create(:user) }
  let(:kit) { create(:kit, shop: user.shop) }
  let!(:voucher) { create(:voucher, voucher_bundle: create(:voucher_bundle, kit: kit)) }

  it "deactivates the codes of the manager's pack" do
    sign_in(user)

    post kit_voucher_deactivation_path(kit)

    expect(response).to redirect_to(kit_path(kit))
    expect(flash[:notice]).to eq("1 code désactivé.")
    expect(voucher.reload).to be_deactivated
  end

  it "does not touch the pack of another club" do
    other_voucher = create(:voucher)
    sign_in(user)

    post kit_voucher_deactivation_path(other_voucher.voucher_bundle.kit)

    expect(response).to have_http_status(:not_found)
    expect(other_voucher.reload).not_to be_deactivated
  end

  it "redirects an anonymous visitor to the login page" do
    post kit_voucher_deactivation_path(kit)

    expect(response).to redirect_to(new_session_path)
    expect(voucher.reload).not_to be_deactivated
  end
end
