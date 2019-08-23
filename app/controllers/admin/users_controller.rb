class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all 
  end

  def new 
    @user = User.new
  end

  def create
    render html: "creating user "
  end

  def show
    render html: "hello"
  end

  def edit
     @user = User.find(params[:id])
  end

  def destroy 
    #User.delete(params[:id]) if User.exists?(params[:id])
    if User.exists?(params[:id])
      User.delete(params[:id])
      flash[:notice] = "user deleted successfully..."
      redirect_to admin_users_path 
    end
  end
end
