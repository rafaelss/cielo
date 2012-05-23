module Cielo
  class CancelationRequest
    include HappyMapper
    include HTTP

    tag "requisicao-cancelamento"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    element :tid, String
    has_one :shop, Shop
  end
end
