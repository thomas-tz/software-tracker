FactoryBot.define do
  factory :tool do
    name { 'foo' }

    trait :with_user do
      after(:create) do |tool|
        tool.users << create(:user)
      end
    end

    trait :with_category do
      after(:build) do |tool|
        tool.category = create(:category)
      end
    end
  end
end
