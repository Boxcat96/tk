%% ------------------------------------------------------------------------
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
rhos =   0.0 : 0.2 : 0.6;
phipis = 0.6 : 0.2 : 2.0;
phiys =  0.2 : 0.2 : 1.0;
taylor_set = table2array(combinations(rhos, phipis, phiys));

% simlation number of attempts
sim_num = 100;
shock_mean = 0.625;
shock_stdev = 5;
sim_period = 10;

%% ------------------------------------------------------------------------

% -- run for each case
for simcase = 1:3
    % case 1 = ZLB on, Adapt Expectation on
    % case 2 = ZLB on, Adapt Expectation off
    % case 3 = ZLB off, Adapt Expectation off
   
    set_params;
   
    % stochastic simulation
    rand_shock;
end

toc;
close all;
