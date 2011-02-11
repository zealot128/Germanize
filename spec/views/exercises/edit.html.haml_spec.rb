require 'spec_helper'

describe "exercises/edit.html.haml" do
  before(:each) do
    @exercise = assign(:exercise, stub_model(Exercise,
      :name => "MyString",
      :options => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit exercise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => exercises_path(@exercise), :method => "post" do
      assert_select "input#exercise_name", :name => "exercise[name]"
      assert_select "textarea#exercise_options", :name => "exercise[options]"
      assert_select "input#exercise_user_id", :name => "exercise[user_id]"
    end
  end
end
