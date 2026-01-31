# Monte Carlo Option Pricing (MATLAB)

This repository contains MATLAB implementations of Monte Carlo option pricing, with a focus on path-dependent derivatives where closed-form solutions are not available.

The code is written to prioritise clarity and intuition rather than optimisation, and follows the logic of the pricing formulas closely.

## What’s implemented

- Floating-strike lookback **call** option pricing using Monte Carlo simulation  
- Floating-strike lookback **put** option pricing using Monte Carlo simulation  
- Standard error estimation and confidence intervals  
- A convergence analysis showing how the Monte Carlo price and standard error change as the number of simulations increases  

## Method

The underlying asset price is modelled as a geometric Brownian motion. For each simulation, a full price path is generated and the running minimum or maximum is tracked to compute the lookback payoff at maturity. Payoffs are discounted back to present value and averaged to obtain the Monte Carlo price.

## Files

- `lookback_call_mc.m` – Monte Carlo pricing of a floating-strike lookback call  
- `lookback_put_mc.m` – Monte Carlo pricing of a floating-strike lookback put  
- `lookback_call_convergence.m` – convergence and standard error analysis for the lookback call  

## Notes

These scripts were written as part of my own learning and exploration of Monte Carlo methods and path-dependent option pricing. They are intended to be easy to read and adapt, rather than maximally efficient.
