require 'rails_helper'

RSpec.feature "StockViewers", type: :feature, js: true do
  before do
    # Stub client request so no real requests are sent
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
      })
  end

  describe "visiting root path" do
    before do
      visit root_path
    end

    it "shows 'IBM' daily stock prices by default" do
      expect(page).to have_content "Daily stock prices: IBM"
    end

    context "clicking on 'Tesla'" do
      it "shows the daily stock prices for the other stocks" do
        click_link "Tesla"

        expect(page).to have_content "Daily stock prices: TSLA"
      end
    end

    context "clicking on 'Gamestop'" do
      it "shows the daily stock prices for the other stocks" do
        click_link "Gamestop"

        expect(page).to have_content "Daily stock prices: GME"
      end
    end
  end
end
