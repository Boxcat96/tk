% -- extract result

y_tmp      = Simulated_time_series.data(:,1)/4; % 名目金利以外の他系列は年率なので４で割る
pi_tmp     = Simulated_time_series.data(:,2) + (2-terminal_rate);
epi_tmp    = Simulated_time_series.data(:,4) + (2-terminal_rate);
tau_tmp    = Simulated_time_series.data(:,5) + (2-terminal_rate);
r_lb_tmp   = Simulated_time_series.data(:,7);

% save only 1 to 100 periods
y = y_tmp(1:100,:);
pi = pi_tmp(1:100,:);
epi = epi_tmp(1:100,:);
tau = tau_tmp(1:100,:);
r_lb = r_lb_tmp(1:100,:);
data_export = [y pi epi tau r_lb];
size_result = size(data_export,1);

% diff of interest rate
diff_r = [0; diff(r_lb,1)];

% discount factor
discount = beta.^linspace(1,size_result,size_result);

% welfare loss
welfare = discount*(params.omega_u*y.^2+params.omega_pi*(pi-2).^2 ...
    + params.omega_i*diff_r.^2)/size_result;
