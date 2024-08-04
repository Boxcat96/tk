// The RCK model
// Hiro Endo
// Taisuke Nakata	taisuke.nakata@e.u-tokyo.ac.jp
//Quarterly model

//addpath C:\dynare\5.2\matlab
var y pi i OmegaEE OmegaPC OmegaELB rn u V;
varexo e e_rn;
parameters cBETA cSIGMA cKAPPA cLAMBDA cALPHA1 cALPHA2 cRELB cRSTAR shock_size cRhoRN;

load("params_dynare.mat");
set_param_value("cBETA",params.cBETA);
set_param_value("cSIGMA",params.cSIGMA);
set_param_value("cKAPPA",params.cKAPPA);
set_param_value("cLAMBDA",params.cLAMBDA);
set_param_value("cALPHA1",params.cALPHA1);
set_param_value("cALPHA2",params.cALPHA2);
set_param_value("cRELB",params.cRELB);
set_param_value("cRSTAR",params.cRSTAR);
set_param_value("shock_size",params.shock_size);
set_param_value("cRhoRN",params.cRhoRN);

model;

0  = -y + (1-cALPHA1)*y(1) - cSIGMA*(i - pi(1) - rn);
0  = -pi + cKAPPA*y + (1-cALPHA2)*cBETA*pi(1) + e;
0  = -cLAMBDA*y+OmegaEE - cKAPPA*OmegaPC;
0  = -pi + OmegaPC;
0  = cSIGMA*OmegaEE + OmegaELB;
0  = max(cRELB-i,-OmegaELB);
rn = cRSTAR + cRhoRN*(rn(-1) - cRSTAR) + e_rn*shock_size;
u = -0.5*(y^2 + pi^2);
V =  u + cBETA*V(1);
end;

initval;
y  = 0;
pi = 0;
i  = cRSTAR;
rn = cRSTAR;
OmegaEE=0;
OmegaPC=0;
OmegaELB=0;
e     = 0;
u     = 0;
V     = 0;
end;

steady;
resid;
check;

shocks;
var e_rn;      
periods 1;  
values 1;
end;


simul(periods=50);
save disc_results y pi i OmegaEE OmegaPC OmegaELB rn u V cRELB

//figure(1);
//subplot(1,3,1)
//plot([0:30],400*i(1:31));
//title('政策金利')
//subplot(1,3,2)
//plot([0:30],100*y(1:31));
//title('産出量ギャップ')
//subplot(1,3,3)
//plot([0:30],400*pi(1:31));
//title('インフレ率')

//oo_.exo_simul

//figure(2);
//subplot(3,2,1)
//plot([0:30],400*i(1:31));
//title('i')
//subplot(3,2,2)
//plot([0:30],100*y(1:31));
//title('y')
//subplot(3,2,3)
//plot([0:30],400*pi(1:31));
//title('pi')
//subplot(3,2,4)
//plot([0:30],OmegaEE(1:31));
//title('OmegaEE')
//subplot(3,2,5)
//plot([0:30],OmegaPC(1:31));
//title('OmegaPC')




