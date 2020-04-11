FactoryBot.define do
  factory :post do
    sequence(:phrase) { "This is a test." }
    sequence(:language) { 1 }
    sequence(:detail) { "detail" }
    sequence(:is_original) { true }
    sequence(:is_sharing) { true }
  end
end