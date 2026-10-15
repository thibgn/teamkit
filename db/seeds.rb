password = "password"

lyon = Shop.find_or_create_by!(slug: "as-lyon") { |s| s.name = "AS Lyon Football" }
nantes = Shop.find_or_create_by!(slug: "rc-nantes") { |s| s.name = "RC Nantes Rugby" }

User.find_or_create_by!(email_address: "manager@as-lyon.test") { |u| u.shop = lyon; u.password = password }
User.find_or_create_by!(email_address: "manager@rc-nantes.test") { |u| u.shop = nantes; u.password = password }

[lyon, nantes].each do |shop|
  next if shop.kits.exists?

  jersey = shop.products.create!(title: "Maillot match")
  shorts = shop.products.create!(title: "Short")
  variants = [jersey, shorts].flat_map { |p| %w[10A 12A S M].map { |size| p.variants.create!(size: size, price_cents: 3500) } }

  u13 = shop.kits.create!(title: "Pack U13", price_cents: 6500, published_at: 1.month.ago)
  u15 = shop.kits.create!(title: "Pack U15", price_cents: 7500, published_at: 1.month.ago)
  old = shop.kits.create!(title: "Pack 2024", price_cents: 6000, published_at: 2.years.ago, archived_at: 1.year.ago)
  [u13, u15, old].each { |kit| kit.variants << variants.first(2) }

  old.create_voucher_bundle!(expected_quantity: 5).tap do |old_bundle|
    5.times { |i| old_bundle.vouchers.create!(code: "#{shop.slug.upcase.tr("-", "")}-2024-#{format("%03d", i + 1)}") }
  end

  bundle = u13.create_voucher_bundle!(expected_quantity: 10)
  10.times do |i|
    code = "#{shop.slug.upcase.tr("-", "")}-U13-#{format("%03d", i + 1)}"
    voucher = bundle.vouchers.create!(code: code)
    case i
    when 0..3 then voucher.update!(assigned_to_email: "parent#{i + 1}@example.test", notified_at: 3.days.ago)
    when 4 then voucher.update!(redeemed_at: 1.day.ago) # distributed by hand, no email recorded
    end
    if i < 2
      voucher.update!(redeemed_at: 1.day.ago)
      Order.create!(shop: shop, kit: u13, voucher: voucher, customer_email: voucher.assigned_to_email, total_cents: 0)
    end
  end
end
