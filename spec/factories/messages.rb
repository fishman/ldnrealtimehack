# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    owner "MyString"
    content "MyText"
  end
end
