# frozen_string_literal: true

module Admin
  # Handles omniauth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    #before_action :find_or_create_user

    def github
      if @user.persisted?
        @user.create_physician
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'github') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        redirect_to new_user_session_url
      end
    end

    def facebook
      if @user.persisted?
        @user.create_physician
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
      else
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to new_user_session_url
      end
    end

    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        @user.create_physician
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
      else
        session['devise.google_data'] = request.env['omniauth.auth']
        redirect_to new_user_session_url
      end
    end

    def failure
      redirect_to root_path
    end

    private

    def find_or_create_user
      # You need to implement the method below in your user model
      @user = User.from_omniauth(request.env['omniauth.auth'])
    end
  end
end
