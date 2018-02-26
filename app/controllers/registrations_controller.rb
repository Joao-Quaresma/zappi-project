class RegistrationsController < Devise::RegistrationsController
 
  private
  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :username,
      :first_name,
      :last_name,
      :role
      )
  end
  def account_update_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :username,
      :first_name,
      :last_name,
      :role
      )
  end
end