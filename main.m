% -- Add Dynare Path
addpath c:\dynare\5.5\matlab

% -- Run Dynare
dynare inf_lb

% ショックの大きさ＝1/(1-rho)*変更後の定常状態のインフレ率(ベースラインは0.5)
terminal_rate = 0.5; % ターミナルレート

% -- Save Result
y      = Simulated_time_series.data(:,1)/4; % 名目金利以外の他系列は年率なので４で割る
pi     = Simulated_time_series.data(:,2) + (2-terminal_rate);
epi    = Simulated_time_series.data(:,4) + (2-terminal_rate);
tau    = Simulated_time_series.data(:,5) + (2-terminal_rate);
r_lb   = Simulated_time_series.data(:,7);
data_export = [y pi epi tau r_lb];

% -- Export Result
xlswrite('result/result_1.xlsx', data_export);

disp('インフレ目標のショックサイズは')
disp(1/(1-rho)*terminal_rate);

close all;