% -- Add Dynare Path
addpath c:\dynare\5.5\matlab

% -- Run Dynare
dynare inf_lb

% -- Save Result
y      = Simulated_time_series.data(:,1);
pi     = Simulated_time_series.data(:,2);
IPI    = Simulated_time_series.data(:,3);
epi    = Simulated_time_series.data(:,4);
tau    = Simulated_time_series.data(:,5);
r_lb   = Simulated_time_series.data(:,7);
data_tmp = [y pi epi tau r_lb];

% -- Export Result
xlswrite('result/result_1.xlsx', data_tmp);

% ショックの大きさ＝1/(1-rho)*変更後の定常状態のインフレ率(ベースラインは0.5)
terminal_rate = 0.5; % ターミナルレート

disp('インフレ目標のショックサイズは')
disp(1/(1-rho)*terminal_rate);

close all;