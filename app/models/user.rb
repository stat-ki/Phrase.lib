class User < ApplicationRecord
  # User can register by using email or other SNS account.
  # User can create posts, favotites and sources records after registration.
  # Because there isn't unsubscribing form in application, delete action is executed by using SQL.

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sources, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20],
      name: auth.info.name
    )
    return user
  end

  private

  # Create dummey address to avoid unique constraint.
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
