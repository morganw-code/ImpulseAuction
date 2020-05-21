Rails.application.routes.draw do
  devise_for :users
  get "/", :to => "listings#index", :as => "root"

  post "/listings", to: "listings#create"
  get "/listing/new", :to => "listings#new", :as => "new_listing"
  get "/listing/:id", :to => "listings#show", :as => "listing"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  delete "/listing/:id", :to => "listings#destroy", :as=> "destroy_listing"
  post "/listing/:id", :to => "listings#add_favourite", :as => "listing_favourite"
  # mount ActionCable.server => "cable"

  get "/user/:id", :to => "users#show", :as => :user
  delete "/user/:id", :to => "users#destroy", :as => "destroy_user"

  # admin dashboard
  get "/admin", :to => "admin_dashboard#index", :as => "admin_dashboard"

  patch "/:id", :to => "bids#bid", :as => "bid_listing"

  get "/orders", :to => "orders#index", :as => "orders"
  get "/order/:id", :to => "orders#show", :as => "order"

  get "/payments/success", :to => "payments#success"
  post "/", to: "payments#webhook"

  delete "/favourite/:id", :to => "favourites#destroy", :as=> "destroy_favourite"
end
