module Cielo
  class Error
    include HappyMapper

    tag "erro"
    element :code, Integer, :tag => "codigo"
    element :message, String, :tag => "mensagem"
  end
end
