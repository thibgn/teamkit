require "rails_helper"

RSpec.describe "Kits" do
  let(:user) { create(:user) }

  it "redirects an anonymous visitor to the login page" do
    get kits_path

    expect(response).to redirect_to(new_session_path)
  end

  it "lists the packs of the manager's club only" do
    create(:kit, shop: user.shop, title: "Pack du club")
    create(:kit, title: "Pack d'un autre club")
    sign_in(user)

    get kits_path

    expect(response.body).to include("Pack du club")
    expect(response.body).not_to include("Pack d'un autre club")
  end

  it "does not show the pack of another club" do
    sign_in(user)

    get kit_path(create(:kit))

    expect(response).to have_http_status(:not_found)
  end
end
