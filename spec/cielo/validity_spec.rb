require "spec_helper"

describe Cielo::Validity do
  before do
    Timecop.freeze(Time.parse("2012-05-14 09:23:00"))
  end

  after do
    Timecop.return
  end

  it "raises an exception if year is not valid" do
    expect { described_class.new(Time.now.year - 1, Time.now.month) }.should raise_error(described_class::InvalidDate)
  end

  it "raises an exception if month is not valid" do
    expect { described_class.new(Time.now.year, Time.now.month - 1) }.should raise_error(described_class::InvalidDate)
  end

  it "#to_s" do
    validity = described_class.new(Time.now.year, Time.now.month)
    validity.to_s.should == "201205"
  end
end
