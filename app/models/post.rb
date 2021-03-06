class Post < ApplicationRecord
  # The post which is_sharing false, only user posted can access.
  # The post which is_original false must have source.
  # Language code is based on ISO-639-1.

  belongs_to :user
  has_many :favorites

  validates :source_id, presence: true, unless: :is_original
  validates :phrase, presence: true, length: { maximum: 50 }
  validates :language, presence: true
  validates :is_original, inclusion: {in: [true, false]}
  validates :is_sharing, inclusion: {in: [true, false]}

  enum language: { :ja => 0, :en => 1, :fr => 2, :it => 3, :zh => 4, :other => 5 }

  def favorited_by?(user)
    favorites.find_by(user_id: user.id).present?
  end
end
