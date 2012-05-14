require "spec_helper"

describe Cielo::Configuration do
  subject { described_class.new }

  its(:host) { should == "qasecommerce.cielo.com.br" }
  its(:port) { should == 443 }
  its(:path) { should == "/servicos/ecommwsec.do" }
  its(:logger) { should be_nil }

  context "defining new values" do
    it "changes the host" do
      subject.host = "a.com"
      subject.host.should == "a.com"
    end

    it "changes the port" do
      subject.host = 80
      subject.host.should == 80
    end

    it "changes the path" do
      subject.host = "/something_else"
      subject.host.should == "/something_else"
    end

    it "changes the logger" do
      require "logger"
      MyLogger = Class.new(Logger)

      subject.logger = MyLogger.new(STDOUT)
      subject.logger.should be_instance_of(MyLogger)
    end
  end
end
