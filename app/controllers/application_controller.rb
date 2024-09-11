class ApplicationController < ActionController::Base
  before_action :redirect_authenticated_user, if: :home_page?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address, :description, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address, :description, :photo])
  end

  private

  def home_page?
    params[:controller] == 'pages' && params[:action] == 'home'
  end

  def redirect_authenticated_user
    if user_signed_in?
      redirect_to landing_path
    end
  end
end
