class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_voter
  acts_as_followable
  acts_as_follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :posts

  validates :phone_number, length: { is: 9 , message: 'input 9 symbols please!'}, allow_blank: true, allow_nil: true
  validates :phone_number, format: { with: /\A\d+\z/ , message: "Integer only. No sign allowed."}, allow_blank: true, allow_nil: true
  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  has_many :comchats, through: :subscriptions
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :avatar, AvatarUploader
  self.per_page=5

  delegate :com_chats, :pers_chats, to: :chats
  def self.search(search)
    where("about ILIKE? OR name ILIKE?","%#{search}%", "%#{search}%")
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def informable?
    self == User.current || self.followed_by?(User.current)
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  avatar                 :string
#  about                  :string
#  slug                   :string
#  hobbies                :string
#  city                   :string
#  available_languages    :string
#  education              :string
#  phone_number           :string
#  date_of_birth          :date
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
