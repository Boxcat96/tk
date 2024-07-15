% トイモデル
% 2024/7/31
% Following code is only for "Dynare for MATLAB"

% memo
% 2018年7月の展望レポートBox7のVAR分析も有用
% https://www.boj.or.jp/mopo/outlook/box/data/1807box7a.pdf

// Variables ////////////////////////////////////////////////////////
var y pi IPI epi tau r pistar;  % 内生変数（需給ギャップ、インフレ率、輸入物価、インフレ予想、物価観、名目金利、インフレ目標）
varexo ey eIPI etau epistar er;    % 外生変数（輸入物価上昇ショック、物価観上昇ショック、インフレ目標未達ショック、金融政策ショック）

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

rho = 0.4;         % 名目金利の慣性                  % とりあえず置き

// Alternative setting % 不採用のパラメータ
// lambda = 0.58;    % 粘着情報の度合い               % 北村・田中（2019）

// Equilibrium conditions
model(linear);
y = sigma_1*y(-1) - sigma_2*y(-2) - (1/theta)*(r-epi(+1)) - ey;           % オイラー方程式（誘導形）
pi = gamma*pi(-1) + (1-gamma)*epi(+1) + kappa*y + eta*IPI;                % NKPC
IPI = omega*IPI(-1) + eIPI;                                               % 輸入物価ショックの推移式
epi = (1 - lambda)*((1 - mu)*pi(+1) + mu*tau(-1)) + lambda*(pi(-1));      % インフレ予想の推移（適合的期待）
tau = (1 - alpha)*tau(-1) + alpha*pi + etau;                              % 物価観の推移式
r = tau + rho*r(-1) + (1-rho)*(phipi*(pi-pistar) + phiy*y) + er;          % テイラールール
pistar = pistar(-1) + epistar;                                            % インフレ目標の推移式（permanent shock）
                                                                          % →epistarショックが加わると定常状態が変わる
// Alternative Equations % 不採用の式
//y = y(+1) - (1/theta)*(r-epi(+1));                                      % オイラー方程式
//epi = (1 - lambda)*((1 - mu)*pi(+1) + mu*tau(-1)) + lambda*(epi(-1));   % インフレ予想の推移
end;

// Check the model
steady;   % Check that this is indeed the steady state

// Simulation ////////////////////////////////////////////////////////
shocks;
var epistar;         % インフレ目標未達ショック
periods 1;           % ショック発生期
values 0.83;            % ショックの大きさ
% 1-rhoの逆数を入れると、インフレ率の定常状態が１になる

//var eIPI;          % 輸入物価上昇ショック
//periods 1;         % ショック発生期
//values -5;          % ショックの大きさ

//var er;          % 利上げショック
//periods 1;         % ショック発生期
//values 0.5;          % ショックの大きさ

end;

// Prepare the deterministic simulation of the model over periods
perfect_foresight_setup(periods=40);

// Perform the simulation
perfect_foresight_solver;

// Draw IRFs
rplot y pi epi r tau;