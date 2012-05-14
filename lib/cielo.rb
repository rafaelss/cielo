require "cielo/version"
require "happymapper"

module Cielo
  autoload :Configuration, "cielo/configuration"

  autoload :Shop, "cielo/shop"
  autoload :Order, "cielo/order"
  autoload :Payment, "cielo/payment"
  autoload :Card, "cielo/card"

  autoload :TransactionRequest, "cielo/transaction_request"
  autoload :Transaction, "cielo/transaction"

  autoload :AuthorizationRequest, "cielo/authorization_request"
  autoload :Authorization, "cielo/authorization"

  autoload :CaptureRequest, "cielo/capture_request"
  autoload :Capture, "cielo/capture"

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration if block_given?
    end

    def logger
      configuration.logger ||= begin
        require "logger"
        Logger.new(STDOUT)
      end
    end
  end
end
