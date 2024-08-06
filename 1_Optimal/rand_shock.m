%% generate shocks
if simcase == 1
    % for reproducibility, fix the seed
    rng('default') 
    rand_origin = normrnd(shock_mean, shock_stdev, [1,sim_period*sim_num]);
    save mat/rand_origin.mat rand_origin
else
    load mat/rand_origin.mat
end

% make progress bar
progress_bar = waitbar(0, 'Processing...'); 

%% simulation of randomized shock
for kk = 1:sim_num 
    rand = rand_origin(sim_period*(kk-1)+1:sim_period*kk);
    
    params.rho = optim_taylor(1,1);
    params.phipi = optim_taylor(1,2);
    params.phiy = optim_taylor(1,3);
    save mat/params_dynare.mat params
    save mat/rand.mat rand;

    dynare inf_optim
    save_result;
    result_all_optim(:,:,kk) = data_export;
    rand_all(kk,:) = rand;

    % draw progress bar
    waitbar(kk/sim_num, progress_bar, sprintf('Processing simulation... %d%%', round((kk/sim_num)*100)));
end

% close progress bar
close(progress_bar);

%% save result of simulation
y_sim = squeeze(result_all_optim(:,1,:));
pi_sim = squeeze(result_all_optim(:,2,:));
epi_sim = squeeze(result_all_optim(:,3,:));
tau_sim = squeeze(result_all_optim(:,4,:));
r_sim = squeeze(result_all_optim(:,5,:));

if simcase == 1
    save mat/result_simul_case_1.mat y_sim pi_sim epi_sim tau_sim r_sim
elseif simcase == 2
    save mat/result_simul_case_2.mat y_sim pi_sim epi_sim tau_sim r_sim
elseif simcase == 3
    save mat/result_simul_case_3.mat y_sim pi_sim epi_sim tau_sim r_sim
else
end