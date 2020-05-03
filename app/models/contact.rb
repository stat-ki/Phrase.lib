class Contact < ApplicationRecord
  # Contact records aren't be saved in DB.
  # This model is used to judged validation.

  validates :email, presence: true, length: {maximum:255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :message, presence: true
end
