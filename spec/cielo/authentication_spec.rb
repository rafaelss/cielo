require "spec_helper"

describe Cielo::Authentication do
  let(:xml) { '<autenticacao><codigo>5</codigo><mensagem>Transacao sem autenticacao</mensagem><data-hora>2012-05-23T12:20:26.831-03:00</data-hora><valor>2390</valor><eci>1</eci></autenticacao>' }
  subject { described_class.parse(xml, :single => true) }
  its(:code) { should == 5 }
  its(:message) { should == "Transacao sem autenticacao" }
  its(:time) { should == Time.parse("2012-05-23T12:20:26.831-03:00") }
  its(:total) { should == 2390 }
  its(:eci) { should == 1 }
end
