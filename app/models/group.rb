class Group < ApplicationRecord
  belongs_to :user
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  attachment :image

  def groupuser?(user)
    group_users.where(user_id: user.id).exists?
  end
end
