class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    #if user_signed_in? and !current_user.admin?
      #render html: "hello guest"
    #end
  end
end
