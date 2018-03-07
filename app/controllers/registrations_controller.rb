class RegistrationsController < Devise::RegistrationsController
 

 
 
  private
  def sign_up_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :role,
      :job_role
      )
  end
  def account_update_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation,
      :current_password,
      :first_name,
      :last_name,
      :role,
      :job_role
      )
  end
end