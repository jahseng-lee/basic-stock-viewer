class AlphaVantageCache < ApplicationRecord
  validates :stock_symbol, presence: true
  validates :response, presence: true
  validates :date, presence: true
end
