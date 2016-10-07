# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :banned?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = 'Account banned!'
      root_path
    end
  end

  def not_authorized
    redirect_to root_path, notice: 'Permission denied!'
  end
end
