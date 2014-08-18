require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :user_id => 1,
      :address => "Address",
      :pay_status => "Pay Status",
      :pay_type => "Pay Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Address/)
    rendered.should match(/Pay Status/)
    rendered.should match(/Pay Type/)
  end
end
