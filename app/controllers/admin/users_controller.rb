class Admin::UsersController < Admin::AdminController

  def index
    role = params[:role]
    if user_signed_in?
      if role == 'administrators'
        @users = User.where(admin:true)
        render 'admin_user'
      elsif role == 'doctor'
        @users = User.where(role:'doctor')
        render 'doctor_user'
      elsif role =='nurse'
        @users = User.where(role:'nurse')
        render 'nurse_user'
      elsif role =='patient'
        @users = User.where(role:'patient')
        render 'patient_user'
      else
        render html: "no genral user found ...under construction..."
      end
    end

  end

  def show
    render html: "hello"
  end
end
