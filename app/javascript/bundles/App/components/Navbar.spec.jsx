/**
 * @jest-environment jsdom
 */

import React from 'react';
import { render, screen } from "@testing-library/react";
import userEvent from '@testing-library/user-event';
import Navbar from "./Navbar";

const mockOnClick = jest.fn();

test('clicking links calls the onClick function', async () => {
  render(<Navbar onClick={mockOnClick} />);

  await userEvent.click(screen.getByText("IBM"));
  expect(mockOnClick).toHaveBeenCalledWith("IBM");

  await userEvent.click(screen.getByText("Tesla"));
  expect(mockOnClick).toHaveBeenCalledWith("TSLA");

  await userEvent.click(screen.getByText("Gamestop"));
  expect(mockOnClick).toHaveBeenCalledWith("GME");
});