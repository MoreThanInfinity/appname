# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  chat_id    :integer
#  created_at :datetime         default(Wed, 21 Feb 2018 13:04:47 UTC +00:00), not null
#  updated_at :datetime         default(Wed, 21 Feb 2018 13:04:47 UTC +00:00), not null
#
# Indexes
#
#  index_messages_on_chat_id  (chat_id)
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
