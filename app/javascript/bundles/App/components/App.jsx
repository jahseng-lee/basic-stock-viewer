import PropTypes from 'prop-types';
import React, { useState, useEffect } from 'react';
import Highcharts from 'highcharts/highstock';
import HighchartsReact from 'highcharts-react-official';

import Navbar from './Navbar';

const App = () => {
  const [stockSymbol, setStockSymbol] = useState("IBM");
  const [stockData, setStockData] = useState();
  const [dailyLimitReached, setDailyLimitReached] = useState(false);

  useEffect(() => {
    fetch(`/stock_data/?stock_symbol=${stockSymbol}`)
      .then((response) => response.text())
      .then((data) => {
        const deserializedData = JSON.parse(data);

        if (Object.keys(deserializedData).length === 0) {
          // Empty, assume daily limit reached
          setDailyLimitReached(true);
          return;
        };

        setStockData({
          title: {
            text: `Stock chart: ${stockSymbol}`
          },
          series: [
            {
              data: deserializedData.series_data
            }
          ]
        });
      })
  }, [stockSymbol]);

  const changeStockChart = (_stockSymbol) => {
    setStockSymbol(_stockSymbol);
  };

  return (
    <div>
      <Navbar onClick={changeStockChart} />
      {
        !!stockData && (
          <HighchartsReact
            highcharts={Highcharts}
            constructorType={'stockChart'}
            options={stockData}
          />
        )
      }
      {
        dailyLimitReached && (
          <p>
            Daily limit reached on API calls; please try again tomorrow
          </p>
        )
      }
    </div>
  );
};

App.propTypes = {
  name: PropTypes.string.isRequired, // this is passed from the Rails view
};

export default App;
