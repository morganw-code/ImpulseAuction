class ApplicationController < ActionController::Base
    # permit image field for user registration
    before_action :permit_devise_fields, if: :devise_controller?
    def permit_devise_fields
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :image) }
    end 
end
