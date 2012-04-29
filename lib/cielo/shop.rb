module Cielo
  class Shop
    include HappyMapper

    tag "dados-ec"
    element :number, Integer, :tag => "numero"
    element :key, String, :tag => "chave"
  end
end
