FactoryBot.define do
  factory :petition do
    user_id { 1 }
    answer1 { "MyText" }
    answer2 { "MyText" }
    answer3 { "MyText" }
    accepted_at { "2021-12-13 10:06:53" }
    rejected_at { "2021-12-13 10:06:53" }
  end
end
