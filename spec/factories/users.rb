FactoryBot.define do
  factory :user do
    sequence(:name) { "test_user" }
    sequence(:email) { "test@phraselib.work" }
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end
end