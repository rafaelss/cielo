require "spec_helper"

describe Cielo::InfoRequest do
  let(:shop) do
    Cielo::Shop.new.tap do |s|
      s.number = 1006993069
      s.key = "25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3"
    end
  end

  subject { described_class.new }

  it "returns transaction information of a given tid" do
    request = File.read(File.expand_path("../../fixtures/info_request/request.xml", __FILE__))
    response = File.read(File.expand_path("../../fixtures/info_request/response.xml", __FILE__))

    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=#{request}"
      ).
      to_return(
        :status => 200,
        :body => response,
        :headers => { "Content-Type" => "text/xml" }
      )

    subject.id = 1
    subject.tid = "100699306904CC7E1001"
    subject.shop = shop

    transaction = subject.request
    transaction.tid.should == "100699306904CC7E1001"
  end

  it "returns an error with wrong tid" do
    request = File.read(File.expand_path("../../fixtures/info_request/error_request.xml", __FILE__))
    response = File.read(File.expand_path("../../fixtures/info_request/error_response.xml", __FILE__))

    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=#{request}"
      ).
      to_return(
        :status => 200,
        :body => response,
        :headers => { "Content-Type" => "text/xml" }
      )

    subject.id = 1
    subject.tid = "103760993800001E1001"
    subject.shop = shop

    error = subject.request
    error.should be_instance_of(Cielo::Error)
    error.code.should == 3
    error.message.should_not be_empty
  end
end
