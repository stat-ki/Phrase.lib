class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites

  validates :phrase, presence: true, length: { maximum: 50 }

  enum language: { :ja => 0, :en => 1, :fr => 2, :it => 3, :zh => 4, :other => 5 }

  def favorited_by?(user)
    favorites.find_by(user_id: user.id).present?
  end
end
