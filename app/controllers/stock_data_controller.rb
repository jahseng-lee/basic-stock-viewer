class StockDataController < ApplicationController
  def show
    # TODO this is just a fake API for now
    render json: {
      name: "Fake stock id #{params[:id]}",
      series_data: [1, 2, 1, 4, 3, 6, 7, 3, 8, 6, 9]
    }, status: 200
  end
end
