%% save parames

params.sigma_1 = 1.35;     % 需給ギャップのラグ第1項         % 北村・田中（2019）
beta = 0.99;               % discount rate

params.sigma_2 = 0.38;     % 需給ギャップのラグ第1項         % 北村・田中（2019）
params.theta = 1.5;        % オイラー方程式
params.gamma = 0.31;       % NKPCのバックワード項            % 北村・田中（2019）
params.kappa = 0.14;       % NKPCの需給ギャップ項            % 北村・田中（2019）
params.eta = 0.11;         % 輸入物価への感応度              % 北村・田中（2019）
params.omega = 0.35;       % 輸入物価ショックの慣性          % 北村・田中（2019）
params.mu = 0.51;          % 合理的無関心の度合い            % 北村・田中（2019）
params.alpha = 0.09;       % インフレ率の実績値への感応度    % 北村・田中（2019）
params.omega_pi = 1;       % weight of loss function of central bank
params.omega_u = 1;       % weight of loss function of central bank
params.omega_i = 1;       % weight of loss function of central bank

if simcase == 1
    params.lambda = 0.15;      % 適合的期待の度合い
    params.ZLB = -0.0001;      % ZLB: on
elseif simcase == 2
    params.lambda = 0.00;      % 適合的期待なし
    params.ZLB = -0.0001;      % ZLB: on
elseif simcase == 3
    params.lambda = 0.00;      % 適合的期待なし
    params.ZLB = -100000;      % ZLB: off
else
end

%% comment out
% params.lambda = 0.15;      % 適合的期待の度合い              % とりあえず置き
% params.rho = 0.4;          % 名目金利の慣性                  % とりあえず置き
% params.phipi = 1.0;        % テイラールールのインフレ率項    % 標準的なテイラールール
% params.phiy = 0.5;         % テイラールールの需給ギャップ項  % 標準的なテイラールール