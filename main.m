% -- Add Dynare Path
clear all; clc; tic;
% Set your own Dynare path
addpath c:\dynare\5.5\matlab

% -- shock_size = terminal_rate*(rho+(1-rho)*phipi)/((1-rho)*phipi);
terminal_rate = 0.75; 

% -- parameter setting
set_params;

% -- set params conbination of Taylor Rule
% lower bound, interval, upper bound 
rhos =   0.0 : 0.1 : 0.6;
phipis = 0.5 : 0.1 : 5.0;
phiys =  0.1 : 0.1 : 1.0;
taylor_set = table2array(combinations(rhos, phipis, phiys));

progress_bar = waitbar(0, 'Processing...'); % プログレスバーの作成 
loop_num = size(taylor_set,1);
% loop_num = 10; % for exercise

% calculate for each taylor_set
for ii = 1:loop_num
    taylor_params = taylor_set(ii,:); % rho, phipi, phiy
    params.rho = taylor_params(1,1);
    params.phipi = taylor_params(1,2);
    params.phiy = taylor_params(1,3);
    save mat/params_dynare params
    
    % -- Run Dynare
    try
        % on error resume next
        dynare inf_lb
        save_result;
        result_all(:,:,ii) = data_export;
        welfare_all(ii) = welfare;
    catch
        % if error
        result_all(:,:,ii) = NaN(size(result_all,1), size(result_all,2));
        welfare_all(ii) = NaN;        
    end
    
    % draw progress bar
    waitbar(ii/loop_num, progress_bar, sprintf('Processing... %d%%', round((ii/loop_num)*100)));
end

% close progress bar
close(progress_bar); 

[value, location] = min(welfare_all, [], "includemissing");
optim_taylor = taylor_set(location,:);
optim_taylor_result = result_all(:,:,location);

save result/result optim_taylor optim_taylor_result result_all welfare_all
xlswrite('mat/optim_result.xlsx', optim_taylor_result);

toc;
close all;