module Cielo
  class Authorization
    include HappyMapper

    tag "autorizacao"
    element :code, Integer, :tag => "codigo"
    element :message, String, :tag => "mensagem"
    element :time, Time, :tag => "data-hora"
    element :total, Integer, :tag => "valor"
    element :lr, String
    element :arp, String
    element :nsu, String
  end
end
