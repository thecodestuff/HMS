# frozen_string_literal: true

module Admin
  # Hanlde user action like creating,emailing,editing users
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :find_user, only: %i[update edit]
    before_action :paginate_user, only: %i[index]
    def index
      @users = User.with_attached_avatar
    end

    def get_data
      render json: { data: User.all }
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          update_physician_table(@user)
          # Enqueing email to job
          SendMailJob.perform_later(@user)
          format.html { redirect admin_users_path, 'user created successfully' }
        else
          format.html { render :new, form_errors: @form_errors = @user }
        end
      end
    end

    def update
      if @user.update(user_params)
        flash[:notice] = 'user updated successfully...'
      else
        flash[:alert] = @user.errors.details.to_s
      end
      redirect_to admin_users_path
    end

    def destroy
      User.destroy(params[:id])
      flash[:notice] = 'user deleted successfully'
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(
        :firstname, :lastname, :civil_id, :email, :password,
        :previlige_level, :admin, :department, :phone, :blood_group,
        :age, :house_no, :street, :locality, :city, :provider,
        :state, :country, :pincode, :role, :avatar, :uid
      )
    end

    def find_user
      @user = User.find(params[:id])
    end

    def update_physician_table(user)
      user.create_physician if user.valid? && user.role == 'physician'
    end

    def paginate_user
      @users = User.page(params[:page]).includes(:avatar_attachment)
    end
  end
end
