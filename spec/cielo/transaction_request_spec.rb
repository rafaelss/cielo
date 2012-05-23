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
    stub_request(:post, "https://qasecommerce.cielo.com.br/servicos/ecommwsec.do").
      with(
        :body => "mensagem=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<requisicao-transacao id=\"1\" versao=\"1.1.1\">\n  <dados-ec>\n    <numero>1006993069</numero>\n    <chave>25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3</chave>\n  </dados-ec>\n  <dados-portador>\n    <numero>4012001037141112</numero>\n    <validade>201511</validade>\n    <indicador>1</indicador>\n    <codigo-seguranca>371</codigo-seguranca>\n    <nome-portador>FULANO DE TAL</nome-portador>\n  </dados-portador>\n  <dados-pedido>\n    <numero>285813768</numero>\n    <valor>100</valor>\n    <moeda>986</moeda>\n    <data-hora>2010-07-14T13:56:12</data-hora>\n    <idioma>PT</idioma>\n  </dados-pedido>\n  <forma-pagamento>\n    <bandeira>visa</bandeira>\n    <produto>1</produto>\n    <parcelas>1</parcelas>\n  </forma-pagamento>\n  <url-retorno>http://minha.loja.com/pedido/285813768</url-retorno>\n  <autorizar>2</autorizar>\n  <capturar>false</capturar>\n</requisicao-transacao>\n"
      ).
      to_return(
        :status => 200,
        :body => File.read(File.expand_path("../../fixtures/transaction.xml", __FILE__)),
        :headers => {}
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

    transaction.tid.should == "100699306904CC7E1001"
    transaction.pan.should == "IqVz7P9zaIgTYdU41HaW/OB/d7Idwttqwb2vaTt8MT0="
    transaction.status.should == 0
    transaction.authentication_url = "https://qasecommerce.cielo.com.br/web/index.cbmp?id=4c0476919b9ea10d11f761bd3158bde0"
  end
end
