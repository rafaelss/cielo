require "spec_helper"

describe Cielo::Transaction do
  subject { described_class.new }
  let(:shop) do
    Cielo::Shop.new.tap do |s|
      s.number = 1001734898
      s.key = "e84827130b9837473681c2787007da5914d6359947015a5cdb2b8843db0fa832"
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

    xml.should == File.read(File.expand_path("../../fixtures/transaction.xml", __FILE__))
  end
end
