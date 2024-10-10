import React from 'react';

import * as styles from './Navbar.module.css';

const Navbar = (props) => (
  <div className={styles.Navbar}>
    <div>
      <h1>Basic stock viewer</h1>
    </div>
    <div>
      <a href='#' onClick={() => props.onClick("IBM")}>IBM</a>
      <a href='#' onClick={() => props.onClick("TSLA")}>Tesla</a>
      <a href='#' onClick={() => props.onClick("GME")}>Gamestop</a>
    </div>
  </div>
);

export default Navbar;