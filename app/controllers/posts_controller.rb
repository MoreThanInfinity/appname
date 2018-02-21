class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :vote, :update, :destroy]
  respond_to :html, :js
  before_action :require_permission, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.page(params[:page]).order('created_at DESC')
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
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new, notice: "#{@post.errors.full_messages}" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
        format.js
      else
        format.html { render :edit , notice: "#{@post.errors.full_messages}"}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
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
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'success!' }
      format.json { head :no_content }
      format.js
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
