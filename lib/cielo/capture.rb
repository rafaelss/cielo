module Cielo
  class Capture
    include HappyMapper

    tag "captura"
    element :code, Integer, :tag => "codigo"
    element :message, String, :tag => "mensagem"
    element :time, Time, :tag => "data-hora"
    element :total, Integer, :tag => "valor"
  end
end
