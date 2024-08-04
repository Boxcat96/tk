// 
// addpath c:/dynare/4.6.1/matlab
// dynare linear_nk
//
var y pi i ni rn;
varexo e e_rn;
parameters cBETA cSIGMA cKAPPA cALPHA1 cALPHA2 cRELB cRSTAR cPhiPi cRhoR shock_size;

cBETA = 1/(1+0.005);
cSIGMA = 1;
cKAPPA = (6-1)/500*(1+1);
cALPHA1= 0;
cALPHA2= 0;
cRELB  = 0;
cRSTAR = 1-cBETA;
cPhiPi = 2;
cRhoR  = 0.0;
shock_size = -0.0225;

%shock_size = -0.01;

model;

y  = (1-cALPHA1)*y(1) - cSIGMA*(i - pi(1) - rn);
pi = cKAPPA*y + (1-cALPHA2)*cBETA*pi(1) + e;
ni = cRSTAR + cRhoR*(ni(-1)-cRSTAR) + (1.0-cRhoR)*cPhiPi*pi;
//0  = -ni + rn + cRhoR*(ni(-1)-cRSTAR) + (1.0-cRhoR)*cPhiPi*pi;
i  =  max(ni,cRELB);
rn = cRSTAR + 0.85*(rn(-1) - cRSTAR) + e_rn*shock_size;

end;

initval;

y  = 0;
pi = 0;
i  = cRSTAR;
rn = cRSTAR;
ni = cRSTAR;
e     = 0;
e_rn  = 0;

end;

steady;

shocks;
var e_rn;      
periods 1;  
values 1;
end;

perfect_foresight_setup(periods=100);
perfect_foresight_solver;



