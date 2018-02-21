class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_type
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @chats=chat_type_class.all
  end

  def new
    @chat=chat_type_class.new
  end

  def create
    if (@other_user = User.find(params[:other_user]) if params[:other_user])
    @chat = find_perschat(@other_user) || PersChat.new(identifier: SecureRandom.hex)
      if @chat.new_record?
        @chat.save
        @chat.subscriptions.create(user_id: current_user.id)
        @chat.subscriptions.create(user_id: @other_user.id)
      end
      redirect_to chat_path(@chat)
    else
      @chat=chat_type_class.new(chat_params)
      respond_to do |format|
        if @chat.save!
          @chat.subscriptions.create(user_id: current_user.id)
          @chat.create_activity(:create, owner: current_user)
          format.html {redirect_to chat_path(@chat), notice: "#Chat was successfully created!"}
          format.js
        else
          format.html {render action: 'new', notice: "#{@chat.errors.full_messages}"}
          format.js
        end
      end
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @chat.subscriptions.create(user_id: current_user.id) if (params[:type] == "ComChat" &&
      @chat.subscriptions.where(user_id: current_user.id).empty?)
    @message = Message.new
  end

private

  def chat_params
    params.require(chat_type.underscore.to_sym).permit(:name, :type, :identifier)
  end

  def find_perschat(second_user)
    chats = current_user.chats
    chats.each do |chat|
      chat.subscriptions.each do |s|
        if s.user_id == second_user.id
          return chat
        end
      end
    end
    nil
  end

  def set_chat_type
    @chat_type=chat_type
  end

  def set_chat
    @chat=chat_type_class.find(params[:id])
  end

  def chat_type
    Chat.types.include?(params[:chat_kind])? params[:chat_kind] : "Chat"
  end

  def chat_type_class
    chat_type.constantize
  end

end

