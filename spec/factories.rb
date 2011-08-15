Factory.define(:user) do |f|
  f.sequence(:email) { |n| "user#{n}@example.com" }
  f.password 'password'
end

Factory.define(:profile) do |f|
  f.name 'John Doe'
end
