class ApplicationController < ActionController::Base
  before_action :redirect_authenticated_user, if: :home_page?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address, :description, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address, :description, :photo])
  private
  end

  def home_page?
    params[:controller] == 'pages' && params[:action] == 'home'
  end

  def redirect_authenticated_user
    if user_signed_in?
      redirect_to pets_path
    end
  end
end
