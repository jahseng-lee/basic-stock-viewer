require 'rails_helper'

RSpec.describe AlphaVantageSerializer do
  describe ".call" do
    context "when raw_data is valid" do
      let(:raw_data) do
        # See: https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo
        {
          "Meta Data" => {
            # Don't care about metadata
          },
          "Time Series (Daily)" => {
              "2024-10-09" => {
                  "1. open" => "229.2000",
                  "2. high" => "234.9500",
                  "3. low" => "228.5000",
                  "4. close" => "234.3000",
                  "5. volume" => "5083566"
              },
              "2024-10-08" => {
                  "1. open" => "228.1100",
                  "2. high" => "229.3450",
                  "3. low" => "227.0401",
                  "4. close" => "228.6200",
                  "5. volume" => "3245342"
              },
              "2024-10-07" => {
                  "1. open" => "225.3800",
                  "2. high" => "227.6700",
                  "3. low" => "225.0200",
                  "4. close" => "227.1200",
                  "5. volume" => "3457952"
              },
          }
        }
      end

      it "returns the 'open' price in a series_data" do
        serialized_data = described_class.call(raw_data: raw_data)

        expect(serialized_data).to eq({
          series_data: [
            229.2000,
            228.1100,
            225.3800
          ]
        })
      end
    end

    context "when raw_data is invalid" do
      let(:raw_data) { "Not valid raw data" }

      it "raises an error" do
        expect{ described_class.call(raw_data: raw_data) }
          .to raise_error(described_class::DailyLimitReachedError)
      end
    end
  end
end
