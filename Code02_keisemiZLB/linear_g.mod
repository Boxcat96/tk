// Linear NK model with ELB (with fiscal policy)
// addpath c:/dynare/4.6.1/matlab
// dynare linear_g noclearall

var ni i c y w n pi rn g;
varexo e_rn e_g;

parameters cBETA cCHIc cCHIn cVARPHI cNU cTHETA; 
parameters cRHOr cPHIpi cPHIy cRELB cRSTAR;
parameters cRHOrn cRHOg;
parameters GYSS CYSS;
parameters shock_size_rn shock_size_g;

cBETA   = 1/(1+0.005);
cCHIc   = 1;
cCHIn   = 1;
cVARPHI = 500;
cTHETA  = 6;
cNU     = 1/cTHETA;
cRSTAR  = 2/400;
cRELB   = 0; %0.125/400;
cRHOr   = 0; 
cPHIpi  = 2;
cPHIy   = 0;

cRHOrn = 0.85; 
cRHOg  = 0.85;

GYSS   = 0.2;
CYSS   = 1-GYSS;

//shock_size_rn = -0.03;
shock_size_rn = -0.03;
shock_size_g  = 0.5;

model;

c   = c(1) - 1/cCHIc*(i - pi(1) - rn);
w   = cCHIc*c + cCHIn*n;
pi  = (cTHETA-1)/cVARPHI*w + cBETA*pi(1);
y   = CYSS*c + GYSS*g;
y   = n;
ni  = cRSTAR + cRHOr*(ni(-1)-cRSTAR) + (1-cRHOr)*cPHIpi*pi;
i   = max(ni,cRELB);
rn  = cRSTAR + cRHOrn*(rn(-1) - cRSTAR) + e_rn*shock_size_rn;
g   = cRHOg*g(-1) + e_g*shock_size_g;

end;

initval;

ni    = cRSTAR;
i     = cRSTAR;
c     = 0;
y     = 0;
n     = 0;
w     = 0;
pi    = 0;
rn    = cRSTAR;
g     = 0;

end;

//steady;
//iss = oo_.steady_state;

shocks;
var e_rn;
periods 1;
values 1;
var e_g;      
periods 1;  
values 1;
end;

perfect_foresight_setup(periods=50);
perfect_foresight_solver;

IRFs_b = oo_.endo_simul;
IRFs_exo_b = oo_.exo_simul';

//var ni i c y w n pi rn g;
//varexo e_rn e_g;

Tfig=20;

figure(1);
subplot(3,3,1)
plot([0:Tfig],400*i(1:Tfig+1));
title('i')
subplot(3,3,2)
plot([0:Tfig],400*ni(1:Tfig+1));
title('ni')
subplot(3,3,3)
plot([0:Tfig],400*pi(1:Tfig+1));
title('pi')
subplot(3,3,4)
plot([0:Tfig],100*y(1:Tfig+1));
title('y')
subplot(3,3,5)
plot([0:Tfig],100*c(1:Tfig+1));
title('c')
subplot(3,3,6)
plot([0:Tfig],100*w(1:Tfig+1));
title('w')
subplot(3,3,7)
plot([0:Tfig],400*rn(1:Tfig+1));
title('rn')
subplot(3,3,8)
plot([0:Tfig],100*g(1:Tfig+1));
title('g')


