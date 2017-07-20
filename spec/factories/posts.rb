FactoryGirl.define do
  factory :post do
    title 'Title of the new post'
    body 'Text of the new post'
    user
  end
end
