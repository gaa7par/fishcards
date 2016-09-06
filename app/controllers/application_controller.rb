class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized
    redirect_to root_path, notice: "Some text"
  end
end
