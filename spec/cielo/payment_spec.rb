require "spec_helper"

describe Cielo::Payment do
  subject { described_class.new }

  it "#to_xml" do
    subject.flag = "visa"
    subject.product = 1
    subject.installments = 1
    xml = subject.to_xml

    xml.should == File.read(File.expand_path("../../fixtures/payment.xml", __FILE__))
  end
end
