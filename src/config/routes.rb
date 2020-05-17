Rails.application.routes.draw do
  devise_for :users
  get "/", :to => "listings#index", :as => "root"

  post "/listings", to: "listings#create"
  get "/listing/new", :to => "listings#new", :as => "new_listing"
  get "/listing/:id", :to => "listings#show", :as => "listing"
  delete "/listing/:id", :to => "listings#destroy", :as=> "destroy_listing"
  # mount ActionCable.server => "cable"

  get "/user/:id", :to => "users#show", :as => :user

  # admin dashboard
  get "/admin", :to => "admin_dashboard#index", :as => "admin_dashboard"
  delete "/admin/:id", :to => "admin_dashboard#destroy", :as => "admin_dashboard_destroy_user"

  patch "/:id", :to => "bids#bid", :as => "bid_listing"
end
