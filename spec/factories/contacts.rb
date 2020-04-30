FactoryBot.define do
  factory :contact do
    sequence(:email) { "test@phraselib.work" }
    sequence(:message) { "Contact test" }
  end
end