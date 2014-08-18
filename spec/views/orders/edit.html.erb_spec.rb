require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :user_id => 1,
      :address => "MyString",
      :pay_status => "MyString",
      :pay_type => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_user_id[name=?]", "order[user_id]"
      assert_select "input#order_address[name=?]", "order[address]"
      assert_select "input#order_pay_status[name=?]", "order[pay_status]"
      assert_select "input#order_pay_type[name=?]", "order[pay_type]"
    end
  end
end
