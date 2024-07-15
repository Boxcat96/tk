% トイモデル
% 2024/7/31
% Following code is only for "Dynare for MATLAB"

// Variables ////////////////////////////////////////////////////////
var y pi IPI epi tau r r_lb pistar;  % 内生変数（需給ギャップ、インフレ率、輸入物価、インフレ予想、物価観、名目金利、インフレ目標）
varexo eIPI etau epistar lb;    % 外生変数（輸入物価上昇ショック、物価観上昇ショック、インフレ目標未達ショック、金融政策ショック）

// Parameters ////////////////////////////////////////////////////////
parameters sigma_1 sigma_2 theta gamma kappa eta rho lambda mu alpha omega phipi phiy;

sigma_1 = 1.35;     % 需給ギャップのラグ第1項         % 北村・田中（2019）
sigma_2 = 0.38;     % 需給ギャップのラグ第1項         % 北村・田中（2019）
theta = 1.5;        % オイラー方程式
gamma = 0.31;       % NKPCのバックワード項            % 北村・田中（2019）
kappa = 0.14;       % NKPCの需給ギャップ項            % 北村・田中（2019）
eta = 0.11;         % 輸入物価への感応度              % 北村・田中（2019）
omega = 0.35;       % 輸入物価ショックの慣性          % 北村・田中（2019）
mu = 0.51;          % 合理的無関心の度合い            % 北村・田中（2019）
lambda = 0.15;      % 適合的期待の度合い              % とりあえず置き
alpha = 0.09;       % インフレ率の実績値への感応度    % 北村・田中（2019）
phipi = 1.0;        % テイラールールのインフレ率項    % 標準的なテイラールール
phiy = 0.5;         % テイラールールの需給ギャップ項  % 標準的なテイラールール

rho = 0.4;          % 名目金利の慣性                  % とりあえず置き

// Equilibrium conditions
model;
y = sigma_1*y(-1) - sigma_2*y(-2) - (1/theta)*(r_lb-epi(+1)) ;           % オイラー方程式（誘導形）                                     % オイラー方程式
pi = gamma*pi(-1) + (1-gamma)*epi(+1) + kappa*y + eta*IPI;                % NKPC
IPI = omega*IPI(-1) + eIPI;                                               % 輸入物価ショックの推移式
epi = (1 - lambda)*((1 - mu)*pi(+1) + mu*tau(-1)) + lambda*(pi(-1));      % インフレ予想の推移（適合的期待）
tau = (1 - alpha)*tau(-1) + alpha*pi + etau;                              % 物価観の推移式
r = tau + rho*r(-1) + (1-rho)*(phipi*(pi-pistar) + phiy*y);               % テイラールール
r_lb = max(r, lb);
pistar = pistar(-1) + epistar;                                            % インフレ目標の推移式（permanent shock）
end;

%%set initial and terminal condition to steady state of non-ZLB period
initval;
y = 0;
pi = 0;
IPI = 0;
epi = 0;
tau = 0;
r = 0;
r_lb = 0;
pistar = 0;
end;
steady;   % Check that this is indeed the steady state

// Simulation ////////////////////////////////////////////////////////
shocks;
var epistar;         % インフレ目標未達ショック
periods 1;           % ショック発生期
values 0.8333;       % ショックの大きさ
% ショックの大きさ＝1/(1-rho)*変更後の定常状態のインフレ率(ベースラインは0.5)

//var eIPI;          % 輸入物価上昇ショック
//periods 1;         % ショック発生期
//values -2;          % ショックの大きさ

var lb;               % 実効下限金利
periods 1:50;         % ショック発生期
values -0.00001;      % ショックの大きさ    % default = -0.00001

end;

// Prepare the deterministic simulation of the model over periods
perfect_foresight_setup(periods=50);

// Perform the simulation
perfect_foresight_solver;
perfect_foresight_solver(lmmcp); % Lower Bound

// Draw IRFs
rplot y pi epi r_lb tau;