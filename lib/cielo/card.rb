module Cielo
  class Card
    include HappyMapper

    tag "dados-portador"
    element :number, String, :tag => "numero"
    element :validity, String, :tag => "validade"
    element :indicator, String, :tag => "indicador"
    element :security_code, Integer, :tag => "codigo-seguranca"
    element :owner, String, :tag => "nome-portador"
  end
end
