# Monte Carlo Option Pricing

This project replicates the pricing of European options using Monte Carlo simulation and compares the results to the analytical Black–Scholes formula.

## Objective
To demonstrate how Monte Carlo methods approximate option prices and how convergence improves as the number of simulated paths increases.

## Method
The underlying asset price is modelled as a geometric Brownian motion. Option payoffs are simulated at maturity and discounted back to present value.

## Results
Monte Carlo estimates converge to the analytical Black–Scholes price as the number of simulations increases.

## Limitations
The model assumes constant volatility, no transaction costs, and log-normal asset returns.
