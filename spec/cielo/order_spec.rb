require "spec_helper"

describe Cielo::Order do
  subject { described_class.new }

  before do
    Timecop.freeze(Time.parse("2010-07-14T13:56:12"))
  end

  after do
    Timecop.return
  end

  it "#to_xml" do
    subject.number = 285813768
    subject.total = 1
    subject.currency = 986
    subject.time = Time.now
    subject.language = "PT"
    xml = subject.to_xml

    xml.should == File.read(File.expand_path("../../fixtures/order.xml", __FILE__))
  end
end
