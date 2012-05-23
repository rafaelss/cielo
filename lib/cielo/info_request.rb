module Cielo
  class InfoRequest
    include HappyMapper
    include HTTP

    tag "requisicao-consulta"
    attribute :id, Integer, :on_save => proc { |value| value.to_s }
    attribute :version, String, :tag => "versao", :on_save => proc { |value| value ? value : "1.1.1" }
    element :tid, String
    has_one :shop, Shop
  end
end
