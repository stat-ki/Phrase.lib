class Post < ApplicationRecord
    belongs_to :user
    has_many :favorites

    def favorited_by?(user)
        favorites.find_by(user_id: user.id).present?
    end
end
