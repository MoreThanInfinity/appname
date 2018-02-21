class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users
  before_action :set_user

  def create
    current_user.follow(@user)
    render 'profile/index'
  end

  def destroy
    current_user.stop_following(@user)
    render 'profile/index'
  end

  private

    def set_users
      @users=User.all
    end

    def set_user
      @user=User.find(params[:user_id])
    end

end
