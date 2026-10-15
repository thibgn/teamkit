FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "Club #{n}" }
    sequence(:slug) { |n| "club-#{n}" }
  end

  factory :user do
    shop
    sequence(:email_address) { |n| "manager#{n}@example.test" }
    password { "password" }
  end

  factory :product do
    shop
    title { "Maillot" }
  end

  factory :variant do
    product
    size { "M" }
    price_cents { 3500 }
  end

  factory :kit do
    shop
    title { "Pack U13" }
    price_cents { 6500 }
    published_at { 1.day.ago }

    trait(:archived) { archived_at { 1.hour.ago } }
  end

  factory :voucher_bundle do
    kit
    expected_quantity { 10 }
  end

  factory :voucher do
    voucher_bundle
    sequence(:code) { |n| "CODE-#{n}" }

    trait(:assigned) { sequence(:assigned_to_email) { |n| "parent#{n}@example.test" } }
    trait(:redeemed) { redeemed_at { 1.hour.ago } }
  end

  factory :order do
    shop
    kit
    customer_email { "parent@example.test" }
    total_cents { 0 }
  end
end
