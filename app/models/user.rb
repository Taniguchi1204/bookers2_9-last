class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_book, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, source: :group_id
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy


  attachment :profile_image, destroy: false

  validates :name, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length:{maximum: 50}

  def day_rate
    today = books.where(created_at: Date.today.all_day).count
    yesterday = books.where(created_at: Date.yesterday.all_day).count
    if yesterday == 0
      yesterday += 1
      today / yesterday * 100
    elsif today == 0
      today += 1
      yesterday += 1
      today / yesterday * 100
    else
      today / yesterday * 100
    end
  end

  def week_rate
    week = books.where(created_at: Date.today.all_week).count
    privous_week = books.where(created_at: 1.week.ago.all_day).count
    if privous_week == 0
      privous_week += 1
      week / privous_week * 100
    elsif week == 0
      week += 1
      privous_week += 1
      week / privous_week * 100
    else
      week / privous_week * 100
    end

  end

  def follow(user_id)
      relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationship = relationships.find_by(followed_id: user_id)
    relationship.destroy if relationship
  end

  def following?(user)
    followings.include?(user)
  end
end
