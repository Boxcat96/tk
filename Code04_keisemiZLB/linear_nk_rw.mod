// 
// addpath c:/dynare/4.6.1/matlab
// dynare linear_nk_rw
//
var y pi i iTR z rn p;
varexo e_rn;
parameters cBETA cSIGMA cKAPPA cRELB cRSTAR cPhiPi cRhoR cRhoRN shock_size cALPHA;

load("params_dynare.mat");
set_param_value("cBETA",params.cBETA);
set_param_value("cSIGMA",params.cSIGMA);
set_param_value("cKAPPA",params.cKAPPA);
//set_param_value("cALPHA1",params.cALPHA1);
//set_param_value("cALPHA2",params.cALPHA2);
set_param_value("cRELB",params.cRELB);
set_param_value("cRSTAR",params.cRSTAR);
set_param_value("shock_size",params.shock_size);
set_param_value("cRhoRN",params.cRhoRN);

set_param_value("cPhiPi",params.cPhiPi);
set_param_value("cRhoR",params.cRhoR);
set_param_value("cALPHA",params.cALPHA);

model;
[name='NK-IS']
y   = y(1) - cSIGMA*(i - pi(1) - rn);
[name='NK-PC']
pi  = cKAPPA*y + cBETA*pi(1);
[name='Implied Taylor Rule rate']
//iTR = rn + cPhiPi*pi;
iTR = cRSTAR + cPhiPi*pi;
[name='Policy Rate']
i   = max(iTR - cALPHA*z,cRELB);
[name='Z']
z   = z(-1) + (i(-1) - iTR(-1));
[name='Rn AR(1) process']
rn  = cRSTAR + cRhoRN*(rn(-1) - cRSTAR) + e_rn*shock_size;
[name='Law of motion for the price level']
p=p(-1)+pi;
end;

initval;
y  = 0;
pi = 0;
z  = 0;
i  = cRSTAR;
rn = cRSTAR;
iTR= cRSTAR;
e_rn  = 0;
p=0;
end;

endval;
y  = 0;
pi = 0;
z  = 0;
i  = cRSTAR;
rn = cRSTAR;
iTR= cRSTAR;
e_rn  = 0;
p=0;
end;

steady;
resid;
check;

shocks;
var e_rn;      
periods 1;  
values 1;
end;

perfect_foresight_setup(periods=750);

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



