require "spec_helper"

describe Cielo::Card::Validity do
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

  it "raises an exception if both year and month are not valid" do
    expect { described_class.new(Time.now.year - 1, Time.now.month - 1) }.should raise_error(described_class::InvalidDate)
  end

  describe "#to_s" do
    it "works with current year and month" do
      validity = described_class.new(Time.now.year, Time.now.month)
      validity.to_s.should == "201205"
    end

    it "works with next year but current month" do
      validity = described_class.new(Time.now.year + 1, Time.now.month)
      validity.to_s.should == "201305"
    end

    it "works with next year and next month" do
      validity = described_class.new(Time.now.year + 1, Time.now.month + 1)
      validity.to_s.should == "201306"
    end

    it "works with two-digits month" do
      validity = described_class.new(Time.now.year + 1, 12)
      validity.to_s.should == "201312"
    end
  end
end
