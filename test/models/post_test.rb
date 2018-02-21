# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  content     :text
#  attachments :string
#  post_pict   :string
#  user_id     :integer
#  created_at  :datetime         default(Wed, 21 Feb 2018 13:04:48 UTC +00:00), not null
#  updated_at  :datetime         default(Wed, 21 Feb 2018 13:04:48 UTC +00:00), not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
