require "cielo/card/validity"

module Cielo
  class Card
    include HappyMapper

    tag "dados-portador"
    element :number, String, :tag => "numero"
    element :validity, Validity, :tag => "validade"
    element :indicator, String, :tag => "indicador"
    element :security_code, Integer, :tag => "codigo-seguranca"
    element :owner, String, :tag => "nome-portador"
  end
end
