require "spec_helper"

describe Cielo::Shop do
  subject { described_class.new }

  it "#to_xml" do
    subject.number = 1001734898
    subject.key = "e84827130b9837473681c2787007da5914d6359947015a5cdb2b8843db0fa832"
    xml = subject.to_xml

    xml.should == File.read(File.expand_path("../../fixtures/shop.xml", __FILE__))
  end
end
