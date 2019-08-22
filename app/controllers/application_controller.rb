class ApplicationController < ActionController::Base

  # method to redirect login user to particular route
  def after_sign_in_path_for(resource)
    if current_user.admin?
      stored_location_for(resource) || admin_path
    else
      stored_location_for(resource) || admin_path
    end
  end
end
