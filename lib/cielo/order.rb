module Cielo
  class Order
    include HappyMapper

    tag "dados-pedido"
    element :number, Integer, :tag => "numero"
    element :total, Integer, :tag => "valor", :on_save => proc { |value| (value * 100).to_i }
    element :currency, String, :tag => "moeda"
    element :time, Time, :tag => "data-hora", :on_save => proc { |value| value.strftime("%Y-%m-%dT%H:%M:%S") }
    element :language, String, :tag => "idioma"
  end
end
