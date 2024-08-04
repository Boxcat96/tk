%パラメータ値はHills, Nakata and Schmidt (2019) "Effective lower bound risk"より

params.cbeta = 1/(1+0.0075);
params.cchi_c=1;
params.cchi_n=1;
params.cepsilon=10;%price elasiticity of demand
params.cvarphi=200;%Rotemberg adjustment cost
params.crho_rn = 0.8;


params.ckappa=(params.cchi_c+params.cchi_n)/params.cvarphi;
params.clambda_y=params.ckappa/params.cepsilon;
params.crstar =1/params.cbeta-1;
params.csigma=1/params.cchi_c;%IES of consumption
params.ceta=1/params.cchi_n;%Inverse of labour supply elasticity

params.gh_nodes=10;
% [params.transit,params.val]=Rouwenhorst(params.crho_rn,0,params.std_rn,20);