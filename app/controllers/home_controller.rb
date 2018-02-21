class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  include ApplicationHelper

  def index
  end

  def event
    @friends=@user.all_following
    @activities=[]
    PublicActivity::Activity.order('created_at DESC').all.each do | activity|
      @activities<<activity if (activity.trackable && (activity.owner.informable? || belonging?(activity.trackable)))
    end
    @activities=@activities.paginate(:page => params[:page], per_page: 10)
  end

  private
    def set_user
      @user=current_user
    end
end
