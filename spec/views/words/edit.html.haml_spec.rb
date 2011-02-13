require 'spec_helper'

describe "words/edit.html.haml" do
  before(:each) do
    @word = assign(:word, stub_model(Word,
      :user_id => 1,
      :name => "MyString",
      :translation => "MyText",
      :examples => "MyText",
      :wordform => "MyString",
      :grammar => "MyText",
      :level => 1,
      :stats => "MyText"
    ))
  end

  it "renders the edit word form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => words_path(@word), :method => "post" do
      assert_select "input#word_user_id", :name => "word[user_id]"
      assert_select "input#word_name", :name => "word[name]"
      assert_select "textarea#word_translation", :name => "word[translation]"
      assert_select "textarea#word_examples", :name => "word[examples]"
      assert_select "input#word_wordform", :name => "word[wordform]"
      assert_select "textarea#word_grammar", :name => "word[grammar]"
      assert_select "input#word_level", :name => "word[level]"
      assert_select "textarea#word_stats", :name => "word[stats]"
    end
  end
end
