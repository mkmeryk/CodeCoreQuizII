FactoryBot.define do
  factory :idea do
    sequence(:title){|n| Faker::Quotes::Shakespeare.hamlet_quote + "#{n}"}
    description{Faker::TvShows::BrooklynNineNine.quote}
  end
end
