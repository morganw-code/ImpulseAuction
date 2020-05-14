Rails.application.routes.draw do
  devise_for :users
  get "/", :to => "listings#index", :as => "root"
  get "/listing/:id", :to => "listings#show", :as => "listing"
  delete "/listing/:id", :to => "listings#destroy", :as=> "destroy_listing"
  # mount ActionCable.server => "cable"

  # admin dashboard
  get "/admin", :to => "admin_dashboard#index", :as => "admin_dashboard"
  delete "/admin/:id", :to => "admin_dashboard#destroy", :as => "admin_dashboard_destroy_user"
end
