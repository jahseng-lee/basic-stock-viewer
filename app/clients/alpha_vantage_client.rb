class AlphaVantageClient
  API_KEY = "T6FH1B511K1ILGM8"

  class << self
    def time_series_daily(stock_symbol:)
      today = Date.today
      cache_response = AlphaVantageCache.find_by(
        stock_symbol: stock_symbol,
        date: today
      )

      return JSON.parse(cache_response.response) if cache_response.present?

      url = api_url(stock_symbol: stock_symbol)

      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(
        url,
        {'Content-Type' => 'application/json'}
      )

      response = http.request(request)
      body = JSON.parse(response.body)

      AlphaVantageCache.create!(
        stock_symbol: stock_symbol,
        response: response.body,
        date: today
      )

      body
    end

    private

    def api_url(stock_symbol:)
      "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{stock_symbol}&apikey=#{API_KEY}"
    end
  end
end
