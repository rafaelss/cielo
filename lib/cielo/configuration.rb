module Cielo
  class Configuration
    attr_accessor :host, :port, :path, :logger

    def initialize
      @host = "qasecommerce.cielo.com.br"
      @port = 443
      @path = "/servicos/ecommwsec.do"
    end
  end
end
