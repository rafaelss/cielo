module Cielo
  class AuthorizationRequest
    include HappyMapper

    tag "requisicao-autorizacao-tid"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    element :tid, String
    has_one :shop, Shop

    def authorize
      http = Net::HTTP.new(Cielo.configuration.host, Cielo.configuration.port)
      http.use_ssl = true
      http.open_timeout = 10 * 1000
      http.read_timeout = 40 * 1000
      Cielo.logger.info(http.inspect)

      response = http.request_post(Cielo.configuration.path, "mensagem=#{to_xml}")
      Cielo.logger.info(response.body)

      Transaction.parse(response.body, :single => true)
    end
  end
end
