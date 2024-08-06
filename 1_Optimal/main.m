% -- Add Dynare Path
clear all; clc; tic;
% Set your own Dynare path
addpath c:\dynare\5.5\matlab

% -- option: calculate optimal Taylor rule or NOT
CALC = 1; %(Do = 1, DONT = 0, Default = 1)

% -- shock_size = terminal_rate*(rho+(1-rho)*phipi)/((1-rho)*phipi);
terminal_rate = 1.5; 

% -- set params conbination of Taylor Rule
% lower bound, interval, upper bound 
rhos =   0.0 : 0.1 : 0.9;
phipis = 0.5 : 0.1 : 5.0;
phiys =  0.1 : 0.1 : 1.0;
taylor_set = table2array(combinations(rhos, phipis, phiys));

% simlation number of attempts
sim_num = 10;
shock_mean = 0.625;
shock_stdev = 5;
sim_period = 10;

% -- run for each case
for simcase = 1:3
    set_params;
    
    % calculate optimal taylor rule params
    if CALC == 1
        calc_optim;
    elseif CALC == 0
        if simcase == 1
            load mat/result_optim_case_1.mat
        elseif simcase == 2
            load mat/result_optim_case_2.mat
        elseif simcase == 3
            load mat/result_optim_case_3.mat
        else
        end
    else
    end
    
    % stochastic simulation
    rand_shock;
end

toc;
close all;