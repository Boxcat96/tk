% トイモデル
% 2024/7/31
% Following code is only for "Dynare for MATLAB"

// Variables ////////////////////////////////////////////////////////
var y pi IPI epi tau r r_lb pistar;  % 内生変数（需給ギャップ、インフレ率、輸入物価、インフレ予想、物価観、名目金利、インフレ目標）
varexo eIPI epistar lb;    % 外生変数（輸入物価上昇ショック、物価観上昇ショック、インフレ目標未達ショック、金融政策ショック）

// Parameters ////////////////////////////////////////////////////////
parameters sigma_1 sigma_2 theta gamma kappa eta rho lambda mu alpha omega phipi phiy;

load mat/params_dynare;
load mat/rand;
set_param_value("sigma_1",params.sigma_1);
set_param_value("sigma_2",params.sigma_2);
set_param_value("theta",params.theta);
set_param_value("gamma",params.gamma);
set_param_value("kappa",params.kappa);
set_param_value("eta",params.eta);
set_param_value("omega",params.omega);
set_param_value("mu",params.mu);
set_param_value("lambda",params.lambda);
set_param_value("alpha",params.alpha);
set_param_value("phipi",params.phipi);
set_param_value("phiy",params.phiy);
set_param_value("rho",params.rho);

shock_size = terminal_rate*(rho+(1-rho)*phipi)/((1-rho)*phipi);          % インフレ目標のショックサイズ
ZLB_crit = params.ZLB

// Equilibrium conditions
model;
y = sigma_1*y(-1) - sigma_2*y(-2) - (1/theta)*(r_lb-epi(+1)) ;           % オイラー方程式（誘導形）                                     % オイラー方程式
pi = gamma*pi(-1) + (1-gamma)*epi(+1) + kappa*y + eta*IPI;                % NKPC
//IPI = omega*IPI(-1) + eIPI;                                               % 輸入物価ショックの推移式
IPI = eIPI;                                                                 % 輸入物価ショックの推移式
epi = (1 - lambda)*((1 - mu)*pi(+1) + mu*tau(-1)) + lambda*(pi(-1));      % インフレ予想の推移（適合的期待）
tau = (1 - alpha)*tau(-1) + alpha*pi;                                     % 物価観の推移式
r = tau + rho*r(-1) + (1-rho)*(phipi*(pi-pistar) + phiy*y);    % テイラールール
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
pistar = 0;
end;
steady;   % Check that this is indeed the steady state

// Simulation ////////////////////////////////////////////////////////
shocks;
var epistar;         % インフレ目標未達ショック
periods 1;           % ショック発生期
values (shock_size);       % ショックの大きさ

var eIPI;          % 輸入物価上昇ショック
periods 1:10;         % ショック発生期
values (rand);          % ショックの大きさ

var lb;               % 実効下限金利
periods 1:200;         % 期間
values (ZLB_crit);      % 下限金利    % default = -0.00001

end;

// Prepare the deterministic simulation of the model over periods
perfect_foresight_setup(periods=200);

// Perform the simulation
//perfect_foresight_solver;
perfect_foresight_solver(no_homotopy); % Lower Bound

// Draw IRFs
//rplot y pi epi r_lb tau;