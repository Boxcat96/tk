// 
// addpath c:/dynare/4.6.1/matlab
// dynare linear_nk_nit
//
var y pi i ni p n rn;
varexo e e_rn;
parameters cBETA cSIGMA cKAPPA cALPHA1 cALPHA2 cRELB cRSTAR cPhiN cRhoR cRhoRN shock_size;


load("params_dynare.mat");
set_param_value("cBETA",params.cBETA);
set_param_value("cSIGMA",params.cSIGMA);
set_param_value("cKAPPA",params.cKAPPA);
set_param_value("cALPHA1",params.cALPHA1);
set_param_value("cALPHA2",params.cALPHA2);
set_param_value("cRELB",params.cRELB);
set_param_value("cRSTAR",params.cRSTAR);
set_param_value("shock_size",params.shock_size);

set_param_value("cRhoR",params.cRhoR);
set_param_value("cRhoRN",params.cRhoRN);
set_param_value("cPhiN",params.cPhiN);

model;

y  = (1-cALPHA1)*y(1) - cSIGMA*(i - pi(1) - rn);
pi = cKAPPA*y + (1-cALPHA2)*cBETA*pi(1) + e;
p  = p(-1) + pi;
n  = p + y;
ni = cRSTAR + cPhiN*n;
//ni = rn + cPhiN*n;
i  =  max(ni,cRELB);
rn = cRSTAR + cRhoRN*(rn(-1) - cRSTAR) + e_rn*shock_size;

end;

initval;

y  = 0;
pi = 0;
p  = 0;
n  = 0;
i  = cRSTAR;
rn = cRSTAR;
ni = cRSTAR;
e     = 0;
e_rn  = 0;

end;

steady;
resid;
check;

shocks;
var e_rn;      
periods 1;  
values 1;
end;

perfect_foresight_setup(periods=50);
perfect_foresight_solver;

//oo_.exo_simul

//Tfig= 40;
//
//figure(2);
//subplot(3,2,1)
//plot([0:Tfig],400*i(1:Tfig+1));
//title('R')
//subplot(3,2,2)
//plot([0:Tfig],400*ni(1:Tfig+1));
//title('NR')
//subplot(3,2,3)
//plot([0:Tfig],100*y(1:Tfig+1));
//title('y')
//subplot(3,2,4)
//plot([0:Tfig],400*pi(1:Tfig+1));
//title('Pi')
//subplot(3,2,5)
//plot([0:Tfig],400*rn(1:Tfig+1));
//title('shock')
//
//
//



