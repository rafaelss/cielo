module Cielo
  class Transaction
    include HappyMapper

    tag "requisicao-transacao"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    has_one :shop, Shop
    has_one :order, Order
    has_one :payment, Payment
    element :return_url, String, :tag => "url-retorno"
    element :authorize, Integer, :tag => "autorizar"
    element :capture, Boolean, :tag => "capturar", :on_save => proc { |value| value.to_s }
  end
end
