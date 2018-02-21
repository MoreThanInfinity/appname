# == Schema Information
#
# Table name: subscriptions
#
#  id      :integer          not null, primary key
#  user_id :integer
#  chat_id :integer
#
# Indexes
#
#  index_subscriptions_on_chat_id  (chat_id)
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
