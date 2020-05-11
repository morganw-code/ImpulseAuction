Rails.application.routes.draw do
  get "/", :to => "listings#index", :as => :root
end
