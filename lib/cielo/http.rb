require "net/http"

module Cielo
  module HTTP
    def request
      http = Net::HTTP.new(Cielo.configuration.host, Cielo.configuration.port)
      http.use_ssl = true
      http.open_timeout = 10 * 1000
      http.read_timeout = 40 * 1000
      Cielo.logger.info(http.inspect)

      post_body = "mensagem=#{to_xml}"
      Cielo.logger.info(post_body)

      response = http.request_post(Cielo.configuration.path, post_body)
      Cielo.logger.info(response.body)

      Transaction.parse(response.body, :single => true) || Error.parse(response.body, :single => true)
    end
  end
end
