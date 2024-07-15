addpath c:\dynare\5.5\matlab

dynare inf_zlb

y      = Simulated_time_series.data(:,1);
pi     = Simulated_time_series.data(:,2);
epi    = Simulated_time_series.data(:,4);
tau    = Simulated_time_series.data(:,5);
r      = Simulated_time_series.data(:,6);
pistar = Simulated_time_series.data(:,7);

data_tmp = [y pi epi tau r pistar];

% ショックの大きさ＝1/(1-rho)*変更後の定常状態のインフレ率(ベースラインは0.5)
shocksize_epistar = 1/(1-rho)*0.5;

close all;