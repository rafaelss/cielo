module Cielo
  class Payment
    include HappyMapper

    tag "forma-pagamento"
    element :flag, String, :tag => "bandeira"
    element :product, Integer, :tag => "produto"
    element :installments, Integer, :tag => "parcelas"
  end
end
