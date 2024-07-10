% トイモデル
% 2024/7/31
% Following code is only for "Dynare for MATLAB"

% memo
% 2018年7月の展望レポートBox7のVAR分析も有用
% https://www.boj.or.jp/mopo/outlook/box/data/1807box7a.pdf

// Variables ////////////////////////////////////////////////////////
var y pi IPI epi tau r pistar y_obs pi_obs IPI_obs epi_obs tau_obs pistar_obs;  % 内生変数（需給ギャップ、インフレ率、輸入物価、インフレ予想、物価観、名目金利、インフレ目標）
varexo eIPI etau epistar er uy upi uIPI uepi utau;    % 外生変数（輸入物価上昇ショック、物価観上昇ショック、インフレ目標未達ショック、金融政策ショック）

// Parameters ////////////////////////////////////////////////////////
parameters sigma_1 sigma_2 theta gamma kappa eta rho lambda mu alpha omega phipi phiy nu;

theta = 1.5;        % オイラー方程式
phipi = 1.5;        % テイラールールのインフレ率項    % 標準的なテイラールール
phiy = 0.5;         % テイラールールの需給ギャップ項  % 標準的なテイラールール
nu = 0.999;          % インフレ目標の持続項（推計用の暫定）
rho = 0.85;

// Equilibrium conditions
model(linear);
y = sigma_1*y(-1) - sigma_2*y(-2) - (1/theta)*(r-epi(+1));                      % オイラー方程式（誘導形）
pi = gamma*pi(-1) + (1-gamma)*epi(+1) + kappa*y + eta*IPI;                % NKPC
IPI = omega*IPI(-1) + eIPI;                                               % 輸入物価ショックの推移式
epi = (1 - lambda)*((1 - mu)*pi(+1) + mu*tau(-1)) + lambda*(pi(-1));      % インフレ予想の推移（適合的期待）
tau = (1 - alpha)*tau(-1) + alpha*pi + etau;                              % 物価観の推移式
r = rho*r(-1) + (1-rho)*(phipi*(pi-pistar) + phiy*y) + er;                % テイラールール
pistar = nu*pistar(-1) + epistar;                                            % インフレ目標の推移式（permanent shock）
                                                                          % →epistarショックが加わると定常状態が変わる
% 観測方程式
y_obs= y + uy; %
pi_obs= pi + upi; %
IPI_obs= IPI + uIPI; %
epi_obs= epi + uepi; %
tau_obs= tau + utau; %
pistar_obs= pistar; %

end;

//パート4 推測するパラメータの事前分布
estimated_params;
sigma_1, normal_pdf, 1.3, 0.5;
sigma_2, normal_pdf, 0.5, 0.5;
gamma, beta_pdf, 0.5, 0.15;     % NKPCのバックワード項            % 北村・田中（2019）
kappa, normal_pdf, 0.1, 0.1;    % NKPCの需給ギャップ項            % 北村・田中（2019）
eta, normal_pdf, 0.1, 0.1;      % 輸入物価への感応度              % 北村・田中（2019）
omega, beta_pdf, 0.5, 0.2;      % 輸入物価ショックの慣性          % 北村・田中（2019）
mu, beta_pdf, 0.5, 0.2;         % 合理的無関心の度合い            % 北村・田中（2019）
lambda, beta_pdf, 0.5, 0.2;     % 適合的期待の度合い  
alpha, beta_pdf, 0.09, 0.01;    % インフレ率の実績値への感応度    % 北村・田中（2019）
% rho, beta_pdf, 0.7, 0.2;        % 名目金利の慣性 

stderr eIPI, inv_gamma_pdf, 0.1, inf;
stderr etau, inv_gamma_pdf, 0.1, inf;
stderr epistar, inv_gamma_pdf, 0.1, inf;
stderr er, inv_gamma_pdf, 0.1, inf;
stderr uy, inv_gamma_pdf, 0.1, inf;
stderr upi, inv_gamma_pdf, 0.1, inf;
stderr uepi, inv_gamma_pdf, 0.1, inf;
stderr uIPI, inv_gamma_pdf, 0.1, inf;
stderr utau, inv_gamma_pdf, 0.1, inf;
end;

%パート5 シミュレーション
varobs y_obs pi_obs IPI_obs epi_obs tau_obs pistar_obs; % 読み取る観測データ

estimation(datafile=data_inf, mode_check, mh_replic=10000, mh_nblocks=2,
mh_drop=0.5, mh_jscale=0.48, bayesian_irf);

stoch_simul;