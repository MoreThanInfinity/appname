class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :vote, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]
  require 'will_paginate/array'
  def index
    @navigation= "Posts"
    @searcheable="Post"
    if params[:search]
      posts=Post.search(params[:search])
    else
      posts = Post.all
    end
    @posts=posts.page(params[:page]).order(id: :desc)
  end

  def show
    @comments=@post.comments.page(params[:page]).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @post.destroy
  end

  def vote
    if !current_user.voted_up_on? @post
      @post.liked_by current_user
      @post.create_activity(:like, owner: current_user)
    elsif current_user.voted_up_on? @post
      @post.disliked_by current_user
      activity=PublicActivity::Activity.find_by_trackable_id_and_key(@post.id, "post.like")
      activity.destroy if activity.present?
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :attachments)
    end

    def require_permission
      if current_user != Post.find(params[:id]).user
        redirect_to post_path(@post), notice: "This is not your post"
      end
    end
end
