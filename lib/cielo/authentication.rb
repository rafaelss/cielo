module Cielo
  class Authentication
    include HappyMapper

    tag "autenticacao"
    element :code, Integer, :tag => "codigo"
    element :message, String, :tag => "mensagem"
    element :time, Time, :tag => "data-hora"
    element :total, Integer, :tag => "valor"
    element :eci, Integer
  end
end
