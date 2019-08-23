class Admin::AdminController < ApplicationController
  before_action :authenticate_user!, :get_users_count
  def index
    
  end

  protected

  def get_users_count
    @users  = User.all 
    @admin_count  = @users.where(admin: true).count
    @doctor_count = @users.where(role: 'doctor').count
    @nurse_count = @users.where(role: 'nurse').count
    @patient_count = @users.where(role: 'patient').count
  end
end
