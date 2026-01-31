% Computing the price of a Floating-strike Lookback Call option
clear % clear workspace

tic % start timing

% set all parameters 
S0 = 100; sigma = 0.3; r = 0.04; M = 1E6; T = 1; n = 12;
dt = T/n; % time step (path-dependent so need dt)

C = zeros(1,M); % store discounted payoffs
Smin_all = zeros(1,M); % store minimum price from each path
ST_all   = zeros(1,M); % store final price from each path

for j = 1:M
    
    % simulate one GBM price path
    S = [S0 zeros(1,n)]; % pre-allocate space
    
    for i = 1:n
        S(i+1) = S(i)*exp((r - 0.5*sigma^2)*dt + sigma*sqrt(dt)*randn);
    end
    
    ST   = S(end); % final price
    Smin = min(S); % lowest price reached (this is the floating strike)
    
    % save ST and Smin so they can be used for plotting a payoff diagram
    ST_all(j)   = ST;
    Smin_all(j) = Smin;
    
    % floating-strike lookback call payoff
    C(j) = exp(-r*T) * max(ST - Smin, 0);
end

MC_LookbackCallPrice = mean(C) % MC estimate of lookback call price
MCstd = std(C)/sqrt(M) % standard error

format short g
alpha = 0.95; % confidence level

CI = MC_LookbackCallPrice + norminv(0.5 + alpha/2)*MCstd*[-1 1] % confidence interval

CPUtime = toc % stop timer


% payoff diagram for a look-back strike call

% finding the mean of the all the minimums that were found from above^
Smin_plot = mean(Smin_all);

ST_plot = linspace(Smin_plot, max(ST_all), 300);
Payoff_plot = ST_plot - Smin_plot;

figure
plot(ST_plot, Payoff_plot, 'LineWidth', 1.5)
xlabel('Final price S_T')
ylabel('Payoff')
title('Floating-strike lookback call payoff')
grid on
