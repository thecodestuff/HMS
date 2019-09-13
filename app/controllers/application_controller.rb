class ApplicationController < ActionController::Base
  # method to redirect login user to particular route
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_root_path
  end
end
