# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  identifier :string
#  name       :string
#  type       :string
#  created_at :datetime         default(Wed, 21 Feb 2018 13:04:47 UTC +00:00), not null
#  updated_at :datetime         default(Wed, 21 Feb 2018 13:04:47 UTC +00:00), not null
#

require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
