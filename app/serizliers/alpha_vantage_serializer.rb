# A very simple serializer of Alpha Vantage data
#
# Returns the "open" price of the stock in a series
class AlphaVantageSerializer
  class DailyLimitReachedError < StandardError; end

  def self.call(raw_data:)
    if raw_data["Time Series (Daily)"].nil?
      # Daily limit reached
      raise DailyLimitReachedError, "Daily limit reached for API token"
    end

    {
      series_data: raw_data["Time Series (Daily)"].map{ |_, value|
        value["1. open"].to_f
      }
    }
  end
end
