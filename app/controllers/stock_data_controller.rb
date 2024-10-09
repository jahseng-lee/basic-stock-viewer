class StockDataController < ApplicationController
  def show
    raw_stock_data = AlphaVantageClient.time_series_daily(
      stock_symbol: params[:stock_symbol]
    )

    render json: AlphaVantageSerializer.call(raw_data: raw_stock_data),
      status: 200
  rescue AlphaVantageSerializer::DailyLimitReachedError
    render json: {}, status: 500
  end
end
