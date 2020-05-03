class Source < ApplicationRecord
  # User can edit only source records which is made by own.
  # The products to be searched in Rakuten are changed according to the category.

  belongs_to :user

  validates :user_id, presence: true
  validates :category, presence: true
  validates :author, presence: true
  validates :title, presence: true

  enum category: { :book => 0, :movie => 1, :music => 2, :web => 3, :classic => 4, :other => 5 }
end
