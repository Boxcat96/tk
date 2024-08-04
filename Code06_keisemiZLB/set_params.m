%パラメータ値はNakata and Schmidt (2019) "Gradualism and liquidity traps"をベース

params.cbeta = 0.99;
params.csigma=2;%IES of consumption
params.ceta=0.47;%Inverse of labour supply elasticity
params.cepsilon=10;%price elasiticity of demand
params.ctheta=0.8106;%share of firms that adjust prices each period
params.crho_rn = 0.8;
params.std_rn=0.4/100;


params.ckappa=(1-params.ctheta)*(1-params.ctheta*params.cbeta)*(params.csigma^(-1)+params.ceta)/(params.ctheta*(1+params.ceta*params.cepsilon));
params.clambda_y=params.ckappa/params.cepsilon;
params.crstar =1/params.cbeta-1;
params.gh_nodes=10;
% [params.transit,params.val]=Rouwenhorst(params.crho_rn,0,params.std_rn,20);