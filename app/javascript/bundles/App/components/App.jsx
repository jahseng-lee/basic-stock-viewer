import PropTypes from 'prop-types';
import React, { useState, useEffect } from 'react';
import Highcharts from 'highcharts/highstock';
import HighchartsReact from 'highcharts-react-official';

import Navbar from './Navbar';

const App = () => {
  const [stockId, setStockId] = useState(1);
  const [stockData, setStockData] = useState();

  useEffect(() => {
    fetch(`/stock_data/${stockId}`)
      .then((response) => response.text())
      .then((data) => {
        const deserializedData = JSON.parse(data);

        setStockData({
          title: {
            text: `Stock chart: ${deserializedData.name}`
          },
          series: [
            {
              data: deserializedData.series_data
            }
          ]
        });
      })
  }, [stockId]);

  const changeStockChart = (_stockId) => {
    setStockId(_stockId);
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
    </div>
  );
};

App.propTypes = {
  name: PropTypes.string.isRequired, // this is passed from the Rails view
};

export default App;
