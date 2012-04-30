module Cielo
  class Transaction
    include HappyMapper

    tag "transacao"
    element :tid, String
    element :pan, String
    element :status, Integer
    element :authentication_url, String, :tag => "url-autenticacao"
  end
end
