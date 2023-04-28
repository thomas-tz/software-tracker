FactoryBot.define do
  factory :user do
    first_name { 'foo' }
    last_name { 'bar' }

    trait :with_tool do
      after(:create) do |user|
        user.tools << create(:tool)
      end
    end
  end
end
