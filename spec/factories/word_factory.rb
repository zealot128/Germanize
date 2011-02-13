# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :word do |f|
  f.user_id 1
  f.name "MyString"
  f.translation "MyText"
  f.examples "MyText"
  f.wordform "MyString"
  f.grammar "MyText"
  f.level 1
  f.next_visit "2011-02-13 00:07:32"
  f.stats "MyText"
end
