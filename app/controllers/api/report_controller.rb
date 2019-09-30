# frozen_string_literal: true

module Api
  # return data as json
  class ReportController < ApplicationController
    before_action :find_data

    def generate_appointment_report
      appointment_count = 0, data_hash = {}, new_data_hash = []
      @data.each do |obj|
        appointment_count = !data_hash.keys.include?(obj.id) ? 1 : data_hash[obj.id][:count].to_i + 1
        data_hash[obj.id] = { id: obj.id, user_id: obj.user_id, name: obj.firstname,
                              charge: obj.charge.to_i,
                              count: appointment_count.to_i,
                              total: appointment_count * obj.charge }
      end
      data_hash.each { |obj| new_data_hash << obj[1] }
      render json: { data: new_data_hash }
    end

    private

    def find_data
      @data = Physician.appointments_data
    end
  end
end
