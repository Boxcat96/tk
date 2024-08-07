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

loop_num = size(taylor_set,1);
% loop_num = 10; % for exercise

%% simulation of randomized shock
for ii = 1:loop_num
       
    taylor_params = taylor_set(ii,:); % rho, phipi, phiy
    params.rho = taylor_params(1,1);
    params.phipi = taylor_params(1,2);
    params.phiy = taylor_params(1,3);
    save mat/params_dynare.mat params
   
    for kk = 1:sim_num
        rand = rand_origin(sim_period*(kk-1)+1:sim_period*kk);
        save mat/rand.mat rand;

        dynare inf_optim
        save_result;
        result_all(:,:,kk) = data_export;
        welfare_all_k(:,kk) = welfare;
        rand_all(kk,:) = rand;
    end
   
    % save result of simulation
    y_sim = squeeze(result_all(:,1,:));
    pi_sim = squeeze(result_all(:,2,:));
    epi_sim = squeeze(result_all(:,3,:));
    tau_sim = squeeze(result_all(:,4,:));
    r_sim = squeeze(result_all(:,5,:));
   
    % result for all Taylor Rule
    y_sim_all(:,:,ii) = y_sim;
    pi_sim_all(:,:,ii) = pi_sim;
    epi_sim_all(:,:,ii) = epi_sim;
    tau_sim_all(:,:,ii) = tau_sim;
    r_sim_all(:,:,ii) = r_sim;

    % average of welfare loss of each kk
    welfare_all(:,ii) = mean(welfare_all_k, 2);

    % draw progress bar
    waitbar(ii/loop_num, progress_bar, sprintf('Calculating optimal policy... %d%%', round((ii/loop_num)*100)));
end

% close progress bar
close(progress_bar);

% look for the case of minimum welfare loss
[value, location] = min(welfare_all);
optim_taylor = taylor_set(location,:);

y_sim_optim = y_sim_all(:,:,location);
pi_sim_optim = pi_sim_all(:,:,location);
epi_sim_optim = epi_sim_all(:,:,location);
tau_sim_optim = tau_sim_all(:,:,location);
r_sim_optim = r_sim_all(:,:,location);

if simcase == 1
    save mat/result_simul_case_1.mat y_sim_optim pi_sim_optim epi_sim_optim tau_sim_optim r_sim_optim optim_taylor
elseif simcase == 2
    save mat/result_simul_case_2.mat y_sim_optim pi_sim_optim epi_sim_optim tau_sim_optim r_sim_optim optim_taylor
elseif simcase == 3
    save mat/result_simul_case_3.mat y_sim_optim pi_sim_optim epi_sim_optim tau_sim_optim r_sim_optim optim_taylor
else
end