# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :exercise do |f|
  f.name "MyString"
  f.options "MyText"
  f.user_id 1
end
