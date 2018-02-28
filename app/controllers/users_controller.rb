class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :subscribe]
  respond_to :js, :html
  require 'will_paginate/array'
  def index
    @navigation="People"
    @searcheable="User"
    if params[:search]
      users=User.where('id != ?', current_user.id).search(params[:search])
    else
      users = User.where('id != ?', current_user.id)
    end
    @users=users.page(params[:page]).order('created_at ASC')
  end


  def show
    if @user==current_user
      @navigation='My proile'
    elsif @user!=current_user
      @navigation=@user.name
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to profile_path}
      else
        format.html {redirect_to profile_path}
      end
    end
    @user.update(slug: @user.name.parameterize)
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

  def profile
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit( :name, :about, :avatar, :slug,
     :date_of_birth, :city, :phone_number, :education,
      :available_languages, :hobbies)
  end

end

