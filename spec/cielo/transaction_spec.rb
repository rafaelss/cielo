require "spec_helper"

describe Cielo::Transaction do
  subject { described_class.parse(File.read(File.expand_path("../../fixtures/transaction.xml", __FILE__)), :single => true) }
  its(:tid) { should == "100699306904CC7E1001" }
  its(:pan) { should == "IqVz7P9zaIgTYdU41HaW/OB/d7Idwttqwb2vaTt8MT0=" }
  its(:status) { should == 0 }
  its(:authentication_url) { should == "https://qasecommerce.cielo.com.br/web/index.cbmp?id=f7054b88de13b407d8aa4e802189aa92" }
end
