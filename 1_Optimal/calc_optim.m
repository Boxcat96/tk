% make progress bar
progress_bar = waitbar(0, 'Processing...');
loop_num = size(taylor_set,1);
% loop_num = 10; % for exercise

%% calculate for each taylor_set

for ii = 1:loop_num
    taylor_params = taylor_set(ii,:); % rho, phipi, phiy
    params.rho = taylor_params(1,1);
    params.phipi = taylor_params(1,2);
    params.phiy = taylor_params(1,3);
    save mat/params_dynare params
    
    % -- Run Dynare
    dynare inf_lb
    save_result;
    result_all(:,:,ii) = data_export;
    welfare_all(ii) = welfare;

    % draw progress bar
    waitbar(ii/loop_num, progress_bar, sprintf('Calculating optimal policy... %d%%', round((ii/loop_num)*100)));
end

% close progress bar
close(progress_bar); 

% look for the case of minimum welfare loss
[value, location] = min(welfare_all, [], "includemissing");
optim_taylor = taylor_set(location,:);
optim_taylor_result = result_all(:,:,location);

% save result
if simcase == 1
    save mat/result_optim_case_1.mat optim_taylor optim_taylor_result result_all welfare_all
    xlswrite('result/optim_result_case_1.xlsx', optim_taylor_result);
elseif simcase == 2
    save mat/result_optim_case_2.mat optim_taylor optim_taylor_result result_all welfare_all
    xlswrite('result/optim_result_case_2.xlsx', optim_taylor_result);
elseif simcase == 3
    save mat/result_optim_case_3.mat optim_taylor_result result_all welfare_all
    xlswrite('result/optim_result_case_3.xlsx', optim_taylor_result);
else
end
    
