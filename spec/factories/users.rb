FactoryBot.define do
  factory :user do
    first_name { 'Foo' }
    last_name { 'Bar' }

    trait :with_tool do
      after(:create) do |user|
        user.tools << create(:tool)
      end
    end
  end
end
