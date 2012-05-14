module Cielo
  class CaptureRequest
    include HappyMapper

    tag "requisicao-captura"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    element :tid, String
    has_one :shop, Shop

    def capture
      http = Net::HTTP.new("qasecommerce.cielo.com.br", 443)
      http.use_ssl = true
      http.open_timeout = 10 * 1000
      http.read_timeout = 40 * 1000
      response = http.request_post("/servicos/ecommwsec.do", "mensagem=#{to_xml}")
      Transaction.parse(response.body, :single => true)
    end
  end
end
