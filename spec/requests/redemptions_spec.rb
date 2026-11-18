require "rails_helper"

RSpec.describe "Redemptions" do
  let(:voucher) { create(:voucher) }
  let(:shop) { voucher.voucher_bundle.kit.shop }

  it "accepts a valid code" do
    expect {
      post redemptions_path(shop.slug), params: {code: voucher.code, email: "parent@example.test"}
    }.to change(Order, :count).by(1)

    expect(response).to redirect_to(new_redemption_path(shop.slug))
  end

  it "shows an error for an unknown code" do
    post redemptions_path(shop.slug), params: {code: "NOPE", email: "parent@example.test"}

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include("Code inconnu")
  end

  it "refuses a deactivated code with a clear message and no order" do
    voucher.update!(deactivated_at: Time.current)

    expect {
      post redemptions_path(shop.slug), params: {code: voucher.code, email: "parent@example.test"}
    }.not_to change(Order, :count)

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include(CGI.escapeHTML("Ce code a été désactivé. Contactez votre club pour plus d'informations."))
    expect(voucher.reload).not_to be_redeemed
  end
end
