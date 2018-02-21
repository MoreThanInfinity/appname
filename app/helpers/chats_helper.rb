module ChatsHelper
  def sti_chat_path(type = "chat", chat = nil, action = nil)
    send "#{format_sti(action, type, chat)}_path", chat
  end

  def format_sti(action, type, chat)
    action || chat ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

  def last_messages(chat)
    if chat.messages.size >=3
      chat.messages[-3..-1]
    elsif chat.messages.size == 2
      chat.messages
    elsif chat.messages.size == 1
      chat.messages
    end
  end
end
