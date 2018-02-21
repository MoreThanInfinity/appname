class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  before_action :set_posts
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:vote, :destroy]
  respond_to :js, :html
  before_action :require_permission, only: [:edit, :update, :destroy]

  def create
    @comment=@commentable.comments.new do |comment|
    comment.comment=params[:comment_text]
    comment.user=current_user
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new, notice: "#{@post.errors.full_messages}" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def vote
    if !current_user.voted_up_on? @comment
      @comment.liked_by current_user
    elsif current_user.voted_up_on? @comment
      @comment.disliked_by current_user
    end
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'success!' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def find_commentable
      @commentable_type=params[:commentable_type].classify
      @commentable=@commentable_type.constantize.find(params[:commentable_id])
    end

    def set_posts
      @posts=Post.all
    end

    def set_post
      @post=@commentable
    end

    def set_comment
      @comment=Comment.find(params[:id])
    end

    def require_permission
      if current_user != Comment.find(params[:id]).user
        redirect_to post_path(@post), notice: "This is not your post"
      end
    end

end
