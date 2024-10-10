class CreateAlphaVantageCache < ActiveRecord::Migration[7.2]
  def change
    create_table :alpha_vantage_caches do |t|
      t.text :stock_symbol, null: false
      t.json :response, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
