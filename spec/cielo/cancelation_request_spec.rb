# encoding: utf-8
require "spec_helper"

describe Cielo::CancelationRequest do
  subject { described_class.new }

  let(:shop) do
    Cielo::Shop.new.tap do |s|
      s.number = 1006993069
      s.key = "25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3"
    end
  end

  let(:request_xml) { File.read(File.expand_path("../../fixtures/cancelation_request.xml", __FILE__)) }

  it "#to_xml" do
    subject.shop = shop
    subject.id = 1
    subject.tid = "100699306904CC7E1001"
    xml = subject.to_xml

    xml.should == request_xml
  end

  it "#cancel" do
    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=#{request_xml}"
      ).
      to_return(
        :status => 200,
        :body => File.read(File.expand_path("../../fixtures/transaction_3.xml", __FILE__)),
        :headers => { "Content-Type" => "text/xml" }
      )

    subject.shop = shop
    subject.id = 1
    subject.tid = "100699306904CC7E1001"
    transaction = subject.request

    transaction.tid.should == "100699306904CC7E1001"
    transaction.pan.should == "IqVz7P9zaIgTYdU41HaW/OB/d7Idwttqwb2vaTt8MT0="
    transaction.status.should == 9
    transaction.cancelation.code.should == 9
    transaction.cancelation.message.should == "Transacao cancelada com sucesso"
    transaction.cancelation.time.should == Time.parse("2012-05-14 09:52:14")
    transaction.cancelation.total.should == 100
  end
end
