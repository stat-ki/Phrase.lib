class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites

    validates :phrase, presence: true, length: {maximum: 50}
    validates :is_original, presence: true
    validates :is_sharing, presence: true

    enum language: [:ja, :en, :fr, :it, :zh, :other]

    def favorited_by?(user)
        favorites.find_by(user_id: user.id).present?
    end
end
