% Computing the price of a Floating-strike Lookback Put option
clear % clear workspace

tic % start timing

% set all parameters 
S0 = 100; sigma = 0.3; r = 0.04; M = 1E6; T = 1; n = 12;
dt = T/n; % time step (path-dependent so need dt)

C = zeros(1,M); % store discounted payoffs
Smax_all = zeros(1,M); % store maximum price from each path
ST_all = zeros(1,M); % store final price from each path

for j = 1:M
    
    % simulate one GBM price path
    S = [S0 zeros(1,n)]; % pre-allocate space
    
    for i = 1:n
        S(i+1) = S(i)*exp((r - 0.5*sigma^2)*dt + sigma*sqrt(dt)*randn);
    end
    
    ST   = S(end); % final price
    Smax = max(S); % highest price reached (this is the floating strike)
    
    % save ST and Smax so they can be used for plotting a payoff diagram
    ST_all(j)   = ST;
    Smax_all(j) = Smax;
    
    % floating-strike lookback put payoff
    C(j) = exp(-r*T) * max(Smax - ST, 0);
end

MC_LookbackPutPrice = mean(C) % MC estimate of lookback put price
MCstd = std(C)/sqrt(M) % standard error

format short g
alpha = 0.95; % confidence level

CI = MC_LookbackPutPrice + norminv(0.5 + alpha/2)*MCstd*[-1 1] % confidence interval

CPUtime = toc % stop timer


% payoff diagram for a look-back strike put

% finding the mean of the all the maximums that were found from above^
Smax_plot = mean(Smax_all);

ST_plot = linspace(min(ST_all), Smax_plot, 300);
Payoff_plot = Smax_plot - ST_plot;

figure
plot(ST_plot, Payoff_plot, 'LineWidth', 1.5)
xlabel('Final price S_T')
ylabel('Payoff')
title('Floating-strike lookback put payoff')
grid on
