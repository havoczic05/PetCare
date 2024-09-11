class PagesController < ApplicationController
  before_action :redirect_authenticated_user, only: [:home]

  def home
  end

  private

  def redirect_authenticated_user
    if user_signed_in?
      redirect_to landing_path
    end
  end
end
