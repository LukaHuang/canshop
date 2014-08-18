require 'spec_helper'

describe "orders/new" do
  before(:each) do
    assign(:order, stub_model(Order,
      :user_id => 1,
      :address => "MyString",
      :pay_status => "MyString",
      :pay_type => "MyString"
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", orders_path, "post" do
      assert_select "input#order_user_id[name=?]", "order[user_id]"
      assert_select "input#order_address[name=?]", "order[address]"
      assert_select "input#order_pay_status[name=?]", "order[pay_status]"
      assert_select "input#order_pay_type[name=?]", "order[pay_type]"
    end
  end
end
