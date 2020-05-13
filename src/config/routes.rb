Rails.application.routes.draw do
  devise_for :users
  get "/", :to => "listings#index", :as => :root
  mount ActionCable.server => "cable"
end
