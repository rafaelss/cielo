require "net/http"

module Cielo
  class TransactionRequest
    include HappyMapper

    tag "requisicao-transacao"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    has_one :shop, Shop
    has_one :card, Card
    has_one :order, Order
    has_one :payment, Payment
    element :return_url, String, :tag => "url-retorno"
    element :authorize, Integer, :tag => "autorizar"
    element :capture, Boolean, :tag => "capturar", :on_save => proc { |value| value.to_s }

    def create
      http = Net::HTTP.new("qasecommerce.cielo.com.br", 443)
      http.use_ssl = true
      http.open_timeout = 10 * 1000
      http.read_timeout = 40 * 1000
      response = http.request_post("/servicos/ecommwsec.do", "mensagem=#{to_xml}")
      puts response.body
      Transaction.parse(response.body, :single => true)
    end
  end
end
