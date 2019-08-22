class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    #if user_signed_in? and !current_user.admin?
      #render html: "hello guest"
    #end
    get_users_count
  end

  protected
  def get_users_count
    @users_count  = User.all 
    @admin_count  = @users_count.where(admin:true).count
    @doctor_count = @users_count.where(admin:false).count
    #@nurse_count  =
  end
end
