require "cielo/version"
require "happymapper"

module Cielo
  autoload :Shop, "cielo/shop"
  autoload :Order, "cielo/order"
  autoload :Payment, "cielo/payment"
  autoload :Card, "cielo/card"
  autoload :TransactionRequest, "cielo/transaction_request"
  autoload :Transaction, "cielo/transaction"
  autoload :Configuration, "cielo/configuration"

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration if block_given?
    end
  end
end
