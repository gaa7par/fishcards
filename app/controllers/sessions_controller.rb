class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      redirect_to root_path, alert: 'Your account has been banned!'
    else
      super
    end
  end
end
