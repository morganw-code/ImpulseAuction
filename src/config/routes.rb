Rails.application.routes.draw do
  get "/", :to => "listings#index", :as => :root
  mount ActionCable.server => "cable"
end
