require 'spec_helper'

describe "words/index.html.haml" do
  before(:each) do
    assign(:words, [
      stub_model(Word,
        :user_id => 1,
        :name => "Name",
        :translation => "MyText",
        :examples => "MyText",
        :wordform => "Wordform",
        :grammar => "MyText",
        :level => 1,
        :stats => "MyText"
      ),
      stub_model(Word,
        :user_id => 1,
        :name => "Name",
        :translation => "MyText",
        :examples => "MyText",
        :wordform => "Wordform",
        :grammar => "MyText",
        :level => 1,
        :stats => "MyText"
      )
    ])
  end

  it "renders a list of words" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Wordform".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
