FactoryBot.define do
  factory :post do
    sequence(:phrase) { "This is a test." }
    sequence(:language) { 1 }
    sequence(:detail) { "detail" }
  end
end