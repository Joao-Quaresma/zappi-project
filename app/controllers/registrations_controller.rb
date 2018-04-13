class RegistrationsController < Devise::RegistrationsController
 
=begin enable if we want Admin to not need to input the current password when updating profile
  def update_resource(resource, params)
    if current_user.admin?
      resource.update_without_password(params.except("current_password"))
    end
  end
=end 
 
  private
  def sign_up_params
    params.require(:user).permit(
      :email,
      :username,
      :avatar,
      :resume,
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
      :avatar,
      :resume,
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