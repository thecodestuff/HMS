# frozen_string_literal: true

# Base controller ,all controller drived from applicaton controller
# contains common functionality
class ApplicationController < ActionController::Base
  # method to redirect login user to particular route
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_root_path
  end

  def redirect(path, message)
    redirect_to path, notice: message.to_s
  end
end
