FactoryBot.define do
  factory :petition do
    user_id { 1 }
    question1 { "MyText" }
    question2 { "MyText" }
    question3 { "MyText" }
    accepted_at { "2021-12-12 13:12:50" }
    rejected_at { "" }
  end
end
