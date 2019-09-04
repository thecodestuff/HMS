class Admin::UsersController < ApplicationController
  before_action :find_user, only: %i[update edit]
  after_action :update_physician_table, only: %i[create], if: -> { @user.save }
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect admin_users_path, 'user created successfully' }
      else
        format.html { redirect new_admin_user_path, @user.errors.messages }
      end
    end
  end

  def show
    render html: 'hello'
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'user updated successfully...'
    else
      flash[:alert] = @user.errors.details.to_s
    end
    redirect_to admin_users_path
  end

  def destroy
    User.delete(params[:id])
    flash[:notice] = 'user deleted successfully...'
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :civil_id, :email, :password,
      :previlige_level, :admin, :department, :phone, :blood_group,
      :age, :house_no, :street, :locality, :city,
      :state, :country, :pincode, :role
    )
  end

  def find_user
    @user = User.find(params[:id])
  end

  def redirect(url, message)
    redirect_to url, notice: message.to_s
  end

  def update_physician_table
    @user.create_physician if @user.valid? && @user.role == 'physician'
  end
end
