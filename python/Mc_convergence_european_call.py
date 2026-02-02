import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# fix the seed so the convergence plot is reproducible
np.random.seed(0)

# model and contract parameters
S0 = 100
K = 105
r = 0.05
sigma = 0.2
T = 1

# Black–Scholes price (this is what MC should converge to)
d1 = (np.log(S0 / K) + (r + 0.5*sigma**2)*T) / (sigma*np.sqrt(T))
d2 = d1 - sigma*np.sqrt(T)
BS_price = S0 * norm.cdf(d1) - K * np.exp(-r*T) * norm.cdf(d2)

# different simulation sizes to see how accuracy improves
M_values = [1000, 5000, 10000, 50000, 100000, 200000]

# run MC multiple times for each M to smooth out randomness
n_trials = 10

avg_errors = np.zeros(len(M_values))

for i in range(len(M_values)):

    M = M_values[i]
    trial_errors = np.zeros(n_trials)

    for j in range(n_trials):

        # simulate terminal prices directly under GBM
        Z = np.random.randn(M)
        ST = S0 * np.exp((r - 0.5*sigma**2)*T + sigma*np.sqrt(T)*Z)

        # discounted european call payoffs
        C = np.exp(-r*T) * np.maximum(ST - K, 0)

        MC_price = np.mean(C)

        # how far the MC estimate is from the true BS price
        trial_errors[j] = abs(MC_price - BS_price)

    # average error across trials for this M
    avg_errors[i] = np.mean(trial_errors)

# theoretical Monte Carlo error should decay like 1/sqrt(M)
theoretical_error = avg_errors[0] * np.sqrt(M_values[0] / np.array(M_values))

# plot MC error vs M on a log-log scale
plt.figure()
plt.plot(M_values, avg_errors, marker='o', label='Average MC error')
plt.plot(M_values, theoretical_error, '--', label='1/sqrt(M) reference')

plt.xscale('log')
plt.yscale('log')
plt.xlabel('Number of simulations (M)')
plt.ylabel('|MC price - Black–Scholes price|')
plt.title('Monte Carlo Convergence for European Call Option')
plt.legend()
plt.grid(True)
plt.savefig("figures/mc_convergence_european_call.png")
plt.show()
