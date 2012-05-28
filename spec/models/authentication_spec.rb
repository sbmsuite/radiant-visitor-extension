require File.dirname(__FILE__) + '/../spec_helper'

describe Authentication do
  before(:each) do
    @authentication = Authentication.new
  end

  it "should be valid" do
    @authentication.should be_valid
  end
end
