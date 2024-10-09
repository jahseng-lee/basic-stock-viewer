import PropTypes from 'prop-types';
import React, { useState, useEffect } from 'react';
import Highcharts from 'highcharts/highstock';
import HighchartsReact from 'highcharts-react-official';

const App = () => {
  const [stockData, setStockData] = useState();

  useEffect(() => {
    fetch('/stock_data/1')
      .then((response) => response.text())
      .then((data) => {
        const deserializedData = JSON.parse(data);

        setStockData({
          title: {
            text: `Stock chart: ${deserializedData.name}`
          },
          series: [
            {
              data: deserializedData.seriesData
            }
          ]
        });
      })
  }, []);

  return (
    <div>
      {/* TODO make a header with nav links */}
      <h1>Basic stock viewer</h1>
      <hr />
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
