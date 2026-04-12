class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
skip_before_action :verify_authenticity_token, only: :steam

  def steam
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(:user, @user)
      redirect_to after_sign_in_path_for(@user)
    else
      redirect_to root_path, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end
end