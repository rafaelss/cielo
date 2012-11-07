# encoding: utf-8
module Cielo
  class Authorization
    include HappyMapper

    LR = {
      "00" => "Transação autorizada",
      "01" => "Transação referida pelo emissor",
      "04" => "Cartão com restrição",
      "05" => "Transação não autorizada",
      "06" => "Tente novamente",
      "07" => "Cartão com restrição",
      "12" => "Transação inválida",
      "13" => "Valor inválido",
      "14" => "Cartão inválido",
      "15" => "Emissor inválido",
      "41" => "Cartão com restrição",
      "51" => "Saldo insuficiente",
      "54" => "Cartão vencido",
      "57" => "Transação não permitida",
      "58" => "Transação não permitida",
      "62" => "Cartão com restrição",
      "63" => "Cartão com restrição",
      "76" => "Tente novamente",
      "78" => "Cartão não foi desbloqueado pelo portador",
      "82" => "Transação inválida",
      "91" => "Banco indisponível",
      "96" => "Tente novamente",
      "AA" => "Tente novamente",
      "AC" => "Cartão de débito tentando utilizar produto crédito",
      "GA" => "Transação referida pela Cielo",
      "N7" => "Código de segurança inválido (Visa)"
    }

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
