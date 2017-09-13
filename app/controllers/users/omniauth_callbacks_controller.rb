class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    logger.debug "::: In omniauth_callbacks_controller::facebook"
    @user = User.from_omniauth(request.env["omniauth.auth"])
    logger.debug "::: Got user ", @user

    if @user.persisted?
      logger.debug "::: Persisted"
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      logger.debug "::: Non-persisted"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
      @user.persist
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?

    end
  end

  def failure
    logger.debug "::: In omniauth_callbacks_controller::failure"
    redirect_to root_path
  end
end
