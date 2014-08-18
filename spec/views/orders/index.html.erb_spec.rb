require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
        :user_id => 1,
        :address => "Address",
        :pay_status => "Pay Status",
        :pay_type => "Pay Type"
      ),
      stub_model(Order,
        :user_id => 1,
        :address => "Address",
        :pay_status => "Pay Status",
        :pay_type => "Pay Type"
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Pay Status".to_s, :count => 2
    assert_select "tr>td", :text => "Pay Type".to_s, :count => 2
  end
end
