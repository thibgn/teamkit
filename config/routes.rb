Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :kits, only: %i[index show] do
    resources :vouchers, only: :create
  end
  resources :vouchers, only: :index

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  root "kits#index"

  scope "/:shop_slug" do
    get "redeem", to: "redemptions#new", as: :new_redemption
    post "redeem", to: "redemptions#create", as: :redemptions
  end
end
