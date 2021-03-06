class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :banned?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def banned?
    if current_user&.banned?
      sign_out current_user
      redirect_to root_path, alert: 'Your account has been banned!'
    end
  end

  def not_authorized
    redirect_to root_path, alert: 'Permission denied!'
  end
end
