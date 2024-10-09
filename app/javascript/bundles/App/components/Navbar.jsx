import React from 'react';

import * as styles from './Navbar.module.css';

const Navbar = (props) => (
  <div className={styles.Navbar}>
    <div>
      <h1>Basic stock viewer</h1>
    </div>
    <div>
      <a href='#' onClick={() => props.onClick(1)}>Fake stock 1</a>
      <a href='#' onClick={() => props.onClick(2)}>Fake stock 2</a>
      <a href='#' onClick={() => props.onClick(3)}>Fake stock 3</a>
    </div>
  </div>
);

export default Navbar;