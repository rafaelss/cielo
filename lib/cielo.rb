require "cielo/version"
require "happymapper"

module Cielo
  autoload :Shop, "cielo/shop"
  autoload :Order, "cielo/order"
  autoload :Payment, "cielo/payment"
  autoload :Card, "cielo/card"
  autoload :TransactionRequest, "cielo/transaction_request"
end
