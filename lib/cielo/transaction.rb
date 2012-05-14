module Cielo
  class Transaction
    include HappyMapper

    tag "transacao"
    element :tid, String
    element :pan, String
    element :status, Integer
    element :authentication_url, String, :tag => "url-autenticacao"

    has_one :authorization, Authorization
    has_one :capture, Capture
  end
end
