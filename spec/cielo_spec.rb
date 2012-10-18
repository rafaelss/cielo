require "spec_helper"

describe Cielo do
  it "returns a configuration instance" do
    expect(Cielo.configuration).to be_instance_of(Cielo::Configuration)
  end

  it "yields a configuration instance" do
    configuration = nil
    Cielo.configure { |c| configuration = c }
    expect(configuration).to be_instance_of(Cielo::Configuration)
  end
end
