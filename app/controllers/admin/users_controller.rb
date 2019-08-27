class Admin::UsersController < Admin::AdminController
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
        format.html { redirect_to admin_users_path, notice: 'user created successfully' }
      else
        format.html { redirect_to admin_users_path, notice: @user.errors.details.to_s }
      end
    end
  end

  def show
    render html: 'hello'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'user updated successfully...'
    else
      flash[:alert] = @user.errors.details.to_s
    end
    redirect_to admin_users_path
  end

  def destroy
    # User.delete(params[:id]) if User.exists?(params[:id])
    User.delete(params[:id])
    flash[:notice] = 'user deleted successfully...'
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :firstname,
      :lastname , 
      :civil_id , 
      :email,
      :password,
      :previlige_level ,
      :admin , 
      :department , 
      :phone , 
      :blood_group , 
      :age ,
      :house_no , 
      :street , 
      :locality , 
      :city , 
      :state ,
      :country , 
      :pincode
    )
  end
end
