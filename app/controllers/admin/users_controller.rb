class Admin::UsersController < Admin::AdminController

  def index
    role = params[:role]
    if user_signed_in?
      if role == 'administrators'
        @users = User.where(admin:true)
      elsif role == 'doctors'
        @users = User.where(admin:false)
        render html: "its doctors"
      else
        render html: "no genral user found ...under construction..."
      end
    end

  end

  def show
    render html: "hello"
  end
end
