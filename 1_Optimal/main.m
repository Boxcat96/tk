% -- Add Dynare Path
clear all; clc; tic;
% Set your own Dynare path
addpath c:\dynare\5.5\matlab

% -- shock_size = terminal_rate*(rho+(1-rho)*phipi)/((1-rho)*phipi);
terminal_rate = 1.5; 

% -- parameter setting
for simcase = 1:3
    set_params;
    % -- set params conbination of Taylor Rule
    % lower bound, interval, upper bound 
    rhos =   0.0 : 0.1 : 0.9;
    phipis = 0.5 : 0.1 : 5.0;
    phiys =  0.1 : 0.1 : 1.0;
    taylor_set = table2array(combinations(rhos, phipis, phiys));
    
    % calculate optimal taylor rule params
    calc_optim;

    % simlation number of attempts
    sim_num = 1000;
    shock_mean = 0.625;
    shock_stdev = 5;
    sim_period = 10;
    
    % stochastic simulation
    rand_shock;
end

toc;
close all;