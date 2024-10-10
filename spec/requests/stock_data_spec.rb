require 'rails_helper'

RSpec.describe "StockData", type: :request do
  describe "GET /stock_data" do
    context "when the Alpha Vantage Client returns relevant stock data" do
      before do
        allow(AlphaVantageClient)
          .to receive(:time_series_daily)
          .and_return(
            # See: https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo
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
          })
      end

      it "returns the 'open' data in a time series" do
        get stock_data_path

        expect(response.status).to eq 200
        expect(response.body).to eq({
          series_data: [
            229.2000,
            228.1100,
            225.3800
          ]
        }.to_json)
      end
    end

    context "when the Alpha Vantage Client returns invalid data" do
      before do
        allow(AlphaVantageClient)
          .to receive(:time_series_daily)
          .and_return("Something went wrong")
      end

      it "returns an invalid response" do
        get stock_data_path

        expect(response.status).to eq 500
      end
    end
  end
end
