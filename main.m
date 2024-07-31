% -- Add Dynare Path
addpath c:\dynare\5.5\matlab

% -- ショックの大きさ＝1/(1-rho)*変更後の定常状態のインフレ率(ベースラインは0.5)
terminal_rate = 0.5; % ターミナルレート

% -- Run Dynare
% ベンチマーク
dynare inf_lb
connect_flag = 0;
save_result;
xlswrite('result/benchmark.xlsx', data_export);
save mat/inf_LB data_export
shock_size;

% 0.25bps利上げパターン
dynare inf_lb_25hike
connect_flag = 0;
save_result;
xlswrite('result/25hike.xlsx', data_export);
save mat/25hike data_export
shock_size;

% 輸入物価ショック（プラス）
dynare inf_lb_IPI_plus
connect_flag = 1;
save_result;
xlswrite('result/IPI_plus.xlsx', data_export);

% 輸入物価ショック（マイナス）
dynare inf_lb_IPI_minus
connect_flag = 1;
save_result;
xlswrite('result/IPI_minus.xlsx', data_export);

close all;