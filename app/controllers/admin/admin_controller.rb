# frozen_string_literal: true

module Admin
  # All the admin controller inherited from AdminController
  class AdminController < ApplicationController
    before_action :authenticate_user!
    layout 'admin'

    def redirect(path, message)
      redirect_to path, notice: message.to_s
    end
  end
end
