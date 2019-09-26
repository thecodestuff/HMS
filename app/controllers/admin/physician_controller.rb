# frozen_string_literal: true

module Admin
  # Handle physician action like rate policies etc.
  class PhysicianController < ApplicationController
    before_action :find_physician, only: %i[charges update]

    def charges; end

    def update
      @physician.update(physician_params)

      respond_to do |format|
        format.html { redirect admin_charges_path, 'New Charges applied' }
      end
    end

    private

    def find_physician
      @physician = Physician.find_by user_id: params[:id]
    end

    def physician_params
      params.require(:physician).permit(
        :id, :user_id, :speciality,
        :shift, :charge, :charge_at_weekend
      )
    end
  end
end
