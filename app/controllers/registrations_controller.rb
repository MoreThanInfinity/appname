class RegistrationsController < Devise::RegistrationsController
  def update
    if @user.update(account_update_params)
      redirect_to :root, notice: "Profile was succesfully updated!"
    else
      render :root, notice: "#{@user.errors.full_messages}"
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation, :current_password)
    end
end
