% Computing the price of a Floating-strike Lookback Call option and checking how price + standard error change as M increases

clear % clear workspace

% set all parameters
S0 = 100; sigma = 0.3; r = 0.04; T = 1; n = 12;
dt = T/n; % time step (path-dependent so need dt)

% try different numbers of simulations
M = [1e4 1e5 1e6 1e7];

MC_LookbackCallPrice = zeros(1,4); % store MC prices
MCstd = zeros(1,4); % store standard errors

for k = 1:4
    
    m = M(k); % number of simulations for this run
    C = zeros(1,m); % store discounted payoffs
    
    for j = 1:m
        
        % simulate one GBM price path
        S = [S0 zeros(1,n)]; % pre-allocate space
        
        for i = 1:n
            S(i+1) = S(i)*exp((r - 0.5*sigma^2)*dt + sigma*sqrt(dt)*randn);
        end
        
        ST = S(end); % final price
        Smin = min(S); % lowest price reached (floating strike)
        
        % floating-strike lookback call payoff
        C(j) = exp(-r*T) * max(ST - Smin, 0);
    end
    
    % MC estimate of lookback call price
    MC_LookbackCallPrice(k) = mean(C);
    
    % standard error
    MCstd(k) = std(C)/sqrt(m);
    
end

% plotting how the MC estimate behaves as M increases
figure
plot(M, MC_LookbackCallPrice)
xlabel('Number of simulations M')
ylabel('MC lookback call price')
title('MC convergence: floating-strike lookback call')

% plotting how the standard error changes as M increases
figure
plot(M, MCstd)
xlabel('Number of simulations M')
ylabel('Standard error')
title('Standard error vs M')
