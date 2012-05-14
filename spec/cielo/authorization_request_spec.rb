# encoding: utf-8
require "spec_helper"

describe Cielo::AuthorizationRequest do
  subject { described_class.new }

  let(:shop) do
    Cielo::Shop.new.tap do |s|
      s.number = 1006993069
      s.key = "25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3"
    end
  end

  let(:request_xml) { File.read(File.expand_path("../../fixtures/authorization_request.xml", __FILE__)) }

  it "#to_xml" do
    subject.shop = shop
    subject.id = 2
    subject.tid = "100699306904CC7E1001"
    xml = subject.to_xml

    xml.should == request_xml
  end

  it "#authorize" do
    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<requisicao-autorizacao-tid id=\"1\" versao=\"1.1.1\">\n  <tid>100699306904CC7E1001</tid>\n  <dados-ec>\n    <numero>1006993069</numero>\n    <chave>25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3</chave>\n  </dados-ec>\n</requisicao-autorizacao-tid>\n",
      ).
      to_return(
        :status => 200,
        :body => File.read(File.expand_path("../../fixtures/transaction_2.xml", __FILE__)),
        :headers => { "Content-Type" => "text/xml" }
      )

    subject.shop = shop
    subject.id = 1
    subject.tid = "100699306904CC7E1001"
    transaction = subject.authorize

    transaction.authorization.code.should == 1
    transaction.authorization.message.should == "Transação autorizada"
    transaction.authorization.time.should == Time.new(2010, 7, 14, 13, 56, 12)
    transaction.authorization.total.should == 100
    transaction.authorization.lr.should == 1
    transaction.authorization.arp.should == "a1b2c3"
    transaction.authorization.nsu.should == "5e4d3c"
  end
end
