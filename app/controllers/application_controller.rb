class ApplicationController < ActionController::Base
  before_action :redirect_authenticated_user, if: :home_page?

  private

  def home_page?
    params[:controller] == 'pages' && params[:action] == 'home'
  end

  def redirect_authenticated_user
    if user_signed_in?
      redirect_to pets_path
    end
  end
end

