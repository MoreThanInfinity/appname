class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'will_paginate/array'
  include PublicActivity::StoreController
  respond_to :js, :html
  before_action :set_current_user

  def set_current_user
    User.current = current_user
  end
end
