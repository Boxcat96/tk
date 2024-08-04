% òAç⁄ÅFíáìcë◊óSÅuÉ[Éçã‡óòêßñÒâ∫ÇÃã‡óZê≠çÙÅv
% ëÊ2âÒÅuÉ[Éçã‡óòêßñÒâ∫ÇÃç‡ê≠ê≠çÙÅv
% åoÉZÉ~2021îN2ÅE3åéçÜåfç⁄
% ê}2ÅAê}3

addpath c:/dynare/4.6.1/matlab

dynare linear_g noclearall;

shock_size_rn_vals = [0 -0.03];
shock_size_g_vals = [0 0.5];


Tfig=30;

figure(1)

cIRFs  = zeros(4,Tfig+1);
yIRFs  = zeros(4,Tfig+1);
piIRFs = zeros(4,Tfig+1);
gIRFs  = zeros(4,Tfig+1);
iIRFs  = zeros(4,Tfig+1);

for i_rn=1:2
for i_g=1:2

[i_rn i_g]
set_param_value('shock_size_rn',shock_size_rn_vals(i_rn));
set_param_value('shock_size_g',shock_size_g_vals(i_g));
[shock_size_rn_vals(i_rn) shock_size_g_vals(i_g)]
perfect_foresight_solver;

%var ni i c y w n pi rn g;

csave(i_g+2*(i_rn-1),1)  = 100*oo_.endo_simul(3,2);
ysave(i_g+2*(i_rn-1),1)  = 100*oo_.endo_simul(4,2);
pisave(i_g+2*(i_rn-1),1) = 400*oo_.endo_simul(7,2);
gsave(i_g+2*(i_rn-1),1)  = 100*oo_.endo_simul(9,2);

cIRFs(i_g+2*(i_rn-1),:)  = 100*oo_.endo_simul(3,1:Tfig+1);
yIRFs(i_g+2*(i_rn-1),:)  = 100*oo_.endo_simul(4,1:Tfig+1);
piIRFs(i_g+2*(i_rn-1),:) = 400*oo_.endo_simul(7,1:Tfig+1);
gIRFs(i_g+2*(i_rn-1),:)  = 100*oo_.endo_simul(9,1:Tfig+1);
iIRFs(i_g+2*(i_rn-1),:)  = 400*oo_.endo_simul(2,1:Tfig+1);


subplot(3,2,1)
plot([0:Tfig],400*oo_.endo_simul(2,1:Tfig+1));
title('i')
hold on
subplot(3,2,2)
plot([0:Tfig],400*oo_.endo_simul(7,1:Tfig+1));
title('pi')
hold on
subplot(3,2,3)
plot([0:Tfig],100*oo_.endo_simul(4,1:Tfig+1));
title('y')
hold on
subplot(3,2,4)
plot([0:Tfig],100*oo_.endo_simul(3,1:Tfig+1));
title('c')
hold on
subplot(3,2,5)
plot([0:Tfig],400*oo_.endo_simul(8,1:Tfig+1));
title('rn')
hold on
subplot(3,2,6)
plot([0:Tfig],100*oo_.endo_simul(9,1:Tfig+1));
title('g')

end
end

disp('consumption multiplier (away versus at ELB)')
CYSS/GYSS*[(csave(2)-csave(1))/(gsave(2)-gsave(1)) (csave(4)-csave(3))/(gsave(4)-gsave(3))]

disp('output multiplier (away versus at ELB)')
1/GYSS*[(ysave(2)-ysave(1))/(gsave(2)-gsave(1)) (ysave(4)-ysave(3))/(gsave(4)-gsave(3))]

disp('inflation multiplier (away versus at ELB)')
1/GYSS*[(pisave(2)-pisave(1))/(gsave(2)-gsave(1)) (pisave(4)-pisave(3))/(gsave(4)-gsave(3))]

%% ê}2
figure(2)
subplot(2,2,1)
plot([0:Tfig],iIRFs(1,1:Tfig+1),'k--','LineWidth',1.5)
hold on
plot([0:Tfig],iIRFs(2,1:Tfig+1),'k','LineWidth',1.5)
hold on
plot([0:Tfig],iIRFs(3,1:Tfig+1),'r--','LineWidth',1.5)
hold on
plot([0:Tfig],iIRFs(4,1:Tfig+1),'r','LineWidth',1.5)
hold on
title('Policy rate')
xlabel('Time')
subplot(2,2,2)
plot([0:Tfig],yIRFs(1,1:Tfig+1),'k--','LineWidth',1.5)
hold on
plot([0:Tfig],yIRFs(2,1:Tfig+1),'k','LineWidth',1.5)
hold on
plot([0:Tfig],yIRFs(3,1:Tfig+1),'r--','LineWidth',1.5)
hold on
plot([0:Tfig],yIRFs(4,1:Tfig+1),'r','LineWidth',1.5)
hold on
title('Output')
xlabel('Time')
subplot(2,2,3)
plot([0:Tfig],piIRFs(1,1:Tfig+1),'k--','LineWidth',1.5)
hold on
plot([0:Tfig],piIRFs(2,1:Tfig+1),'k','LineWidth',1.5)
hold on
plot([0:Tfig],piIRFs(3,1:Tfig+1),'r--','LineWidth',1.5)
hold on
plot([0:Tfig],piIRFs(4,1:Tfig+1),'r','LineWidth',1.5)
hold on
title('Inflation')
xlabel('Time')
subplot(2,2,4)
plot([0:Tfig],gIRFs(2,1:Tfig+1),'b','LineWidth',1.5)
title('Government spending')
xlabel('Time')

%% ê}3
figure(3)
subplot(2,2,1)
plot([0:Tfig-1],yIRFs(2,1:Tfig)-yIRFs(1,1:Tfig),'k','LineWidth',1.5)
hold on
plot([0:Tfig-1],yIRFs(4,1:Tfig)-yIRFs(3,1:Tfig),'r','LineWidth',1.5)
title('Effect on output')
xlabel('Time')
subplot(2,2,2)
plot([0:Tfig-1],iIRFs(2,1:Tfig)-iIRFs(1,1:Tfig),'k','LineWidth',1.5)
hold on
plot([0:Tfig-1],iIRFs(4,1:Tfig)-iIRFs(3,1:Tfig),'r','LineWidth',1.5)
title('Effect on the policy rate')
xlabel('Time')

