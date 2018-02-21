class UsersController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :subscribe]
  respond_to :js, :html

  def index
    @users=User.where('id != ?', current_user.id).page(params[:page]).order('created_at ASC')
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to :root, notice: "Profile was succesfully updated!"
    else
      render :root, notice: "#{@user.errors.full_messages}"
    end
  end

  def subscribe
    if !@user.followed_by? current_user
      current_user.follow @user
      Follow.last.create_activity(:create, owner: current_user)
    elsif @user.followed_by? current_user
      current_user.stop_following @user
      @follow=Follow.find_by_follower_id_and_followable_id(current_user.id, @user.id)
      activity=PublicActivity::Activity.find_by_trackable_id_and_key('@follow.id' , "follow.create")
      activity.destroy if activity.present?
    end
    respond_to do |format|

      format.html { redirect_to @user, notice: 'You succesfully subscribed!' }
      format.json { render :show, status: :created, location: @user }
      format.js
    end
  end

  private

  def set_user
    @user=User.find(params[:id])
  end

  def user_params
    params.require(:user).permit( :name, :about, :avatar)
  end

end

