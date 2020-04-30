FactoryBot.define do
  factory :source do
    sequence(:category) { 0 }
    sequence(:author) { "author" }
    sequence(:title) { "title" }
  end
end