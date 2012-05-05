# CieloX

Gem para integração de pagamentos via Cielo

## Instalação

Adicione a gem ao seu Gemfile

    gem 'cielox'

E depois execute:

    $ bundle

Ou instale usando:

    $ gem install cielox

## Uso

    request = Cielo::TransactionRequest.new
    request.id = "1"
    request.return_url = "http://minha.loja.com/pedido/285813768"
    request.authorize = 2
    request.capture = false

    request.card = Cielo::Card.new
    request.card.number = "4012001037141112"
    request.card.validity = "201511"
    request.card.indicator = 1
    request.card.security_code = 371
    request.card.owner = "FULANO DE TAL"

    request.shop = Cielo::Shop.new
    request.shop.number = 1006993069
    request.shop.key = "25fbb99741c739dd84d7b06ec78c9bac718838630f30b112d033ce2e621b34f3"

    request.order = Cielo::Order.new
    request.order.number = 285813768
    request.order.total = 1
    request.order.currency = 986 # reais
    request.order.time = Time.now
    request.order.language = "PT"

    request.payment = Cielo::Payment.new
    request.payment.flag = "visa"
    request.payment.product = 1
    request.payment.installments = 1

    transaction = request.create # retorna uma instância de Transaction

## Contribuindo

1. Fork o projeto
2. Crie seu feature branch (`git checkout -b my-new-feature`)
3. Commit as alterações (`git commit -am 'add some feature'`)
4. Push para o branch (`git push origin my-new-feature`)
5. Crie um novo pull request
