class CurrencyExchange
  require 'faraday'
  require 'json'

  def create(transaction_abbreviation, wallet_abbreviation)
    web = 'https://free.currconv.com'
    url = "#{web}/api/v7/convert?q=#{transaction_abbreviation}_#{wallet_abbreviation}&compact=ultra&apiKey=e7774d79343719090739"
    response = Faraday.get(url, { 'Accept' => 'application/json' })
    if response.status == 200
      btn_price = JSON.parse(response.body)
      btn_price["#{transaction_abbreviation}_#{wallet_abbreviation}"]
    else
      'something went wrong'
    end
  end
end
