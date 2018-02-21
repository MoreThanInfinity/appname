class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  include PublicActivity::Model
  acts_as_votable
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  self.per_page = 5
  tracked only: [:create], owner: proc{|_controller, model| model.user}
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  role             :string           default("comments")
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_comments_on_commentable_id    (commentable_id)
#  index_comments_on_commentable_type  (commentable_type)
#  index_comments_on_user_id           (user_id)
#
