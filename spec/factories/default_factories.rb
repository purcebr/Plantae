FactoryGirl.define do

  sequence :unique_name do |n|
    "some cool name#{n}"
  end

  sequence :unique_email do |n|
    "foo#{n}@bar.com"
  end

  factory :user do
    email { generate(:unique_email) }
    password 'foopassw0rd'
  end

  factory :tryst do
    user
    pom_length_s 1500
    break_length_s 500
  end

  factory :time_block do
    tryst
    length_s 1500
    start_time Time.now
  end

  factory :pause do
    time_block
    start_time Time.now
  end


end