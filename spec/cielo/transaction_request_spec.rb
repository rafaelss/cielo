require "spec_helper"

describe Cielo::TransactionRequest do
  subject { described_class.new }

  let(:shop) do
    Cielo::Shop.new.tap do |s|
      s.number = 1006993069
      s.key = "25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3"
    end
  end

  let(:order) do
    Cielo::Order.new.tap do |o|
      o.number = 285813768
      o.total = 1
      o.currency = 986
      o.time = Time.now
      o.language = "PT"
    end
  end

  let(:payment) do
    Cielo::Payment.new.tap do |p|
      p.flag = "visa"
      p.product = 1
      p.installments = 1
    end
  end

  let(:card) do
    Cielo::Card.new.tap do |c|
      c.number = "4012001037141112"
      c.validity = "201511"
      c.indicator = 1
      c.security_code = 371
      c.owner = "FULANO DE TAL"
    end
  end

  before do
    Timecop.freeze(Time.parse("2010-07-14T13:56:12"))
  end

  after do
    Timecop.return
  end

  it "#to_xml" do
    subject.id = "1"
    subject.shop = shop
    subject.order = order
    subject.payment = payment
    subject.return_url = "http://minha.loja.com/pedido/285813768"
    subject.authorize = 2
    subject.capture = false
    xml = subject.to_xml

    xml.should == File.read(File.expand_path("../../fixtures/transaction_request.xml", __FILE__))
  end

  it "#create" do
    request = File.read(File.expand_path("../../fixtures/transaction_request/request.xml", __FILE__))
    response = File.read(File.expand_path("../../fixtures/transaction_request/response.xml", __FILE__))

    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=#{request}"
      ).
      to_return(
        :status => 200,
        :body => response,
        :headers => { "Content-Type" => "text/xml" }
      )

    subject.id = "1"
    subject.card = card
    subject.shop = shop
    subject.order = order
    subject.payment = payment
    subject.return_url = "http://minha.loja.com/pedido/285813768"
    subject.authorize = 2
    subject.capture = false
    transaction = subject.request

    transaction.tid.should have(20).chars
    transaction.pan.should == "IqVz7P9zaIgTYdU41HaW/OB/d7Idwttqwb2vaTt8MT0="
    transaction.status.should == 0
    transaction.authentication_url.should match(/https:\/\/qasecommerce\.cielo\.com\.br\/web\/index.cbmp\?id=.+/)
  end
end
