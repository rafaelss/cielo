require "spec_helper"

describe Cielo::Card do
  subject { described_class.new }

  it "#to_xml" do
    subject.number = "4012001037141112"
    subject.validity = Cielo::Validity.new(2015, 11)
    subject.indicator = 1
    subject.security_code = 371
    subject.owner = "FULANO DE TAL"
    xml = subject.to_xml

    xml.should == File.read(File.expand_path("../../fixtures/card.xml", __FILE__))
  end
end
