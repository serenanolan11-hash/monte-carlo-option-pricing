# Monte Carlo Option Pricing (MATLAB & Python)
This repository contains Monte Carlo implementations of option pricing models in MATLAB and Python, written to emphasise clarity, intuition, and verification rather than optimisation.
The focus is on understanding how Monte Carlo pricing behaves in practice, including benchmarking against analytical results and analysing convergence.

## What’s implemented
- Floating-strike lookback option pricing using Monte Carlo simulation (MATLAB)  
- European call option pricing using Monte Carlo simulation (Python)  
- Black–Scholes closed-form pricing as a benchmark   
- Standard error estimation and convergence analysis  

## Method
The underlying asset price is modelled as a geometric Brownian motion.
Path-dependent options are priced by simulating full price paths and tracking path extrema.  
European options are priced by simulating terminal prices directly.  
Monte Carlo estimates are compared to analytical benchmarks and their convergence behaviour is examined.

## Files
### MATLAB
- `lookback_call_mc.m` – floating-strike lookback call pricing  
- `lookback_put_mc.m` – floating-strike lookback put pricing  
- `lookback_call_convergence.m` – convergence and standard error analysis  
### Python
- `European Call Option Pricing: Monte Carlo Simulation (Black-Scholes Benchmark)` – European call pricing and benchmark comparison  
- `Mc_convergence_european_call.py` – Monte Carlo convergence analysis  
## Figures
- `mc_convergence_european_call.png` – convergence plot showing decay of Monte Carlo pricing error relative to Black–Scholes  

## Notes
These scripts were written as part of my own learning and exploration of Monte Carlo methods and option pricing.
