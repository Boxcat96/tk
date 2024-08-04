% 連載：仲田泰祐「ゼロ金利制約下の金融政策」
% 第2回「ゼロ金利制約下の財政政策」
% 経セミ2021年2・3月号掲載
% 図4

% addpath c:/dynare/4.6.1/matlab
% dynare rank_rotem_fiscal_dynare noclearall

addpath c:/dynare/4.6.1/matlab

dynare linear_g noclearall;

shock_size_rn_vals = 0:-0.002:-0.1;
shock_size_g_vals = [0.0 0.5];

Tfig=20;

figure(1)

for i_rn=1:size(shock_size_rn_vals,2)
for i_g=1:size(shock_size_g_vals,2)

set_param_value('shock_size_rn',shock_size_rn_vals(i_rn));
set_param_value('shock_size_g',shock_size_g_vals(i_g));

perfect_foresight_solver;

%var NR R C Y w N Pi TauH d G;
%varexo A TauC TauN Theta M ed eG;

ysave(i_rn,i_g) = oo_.endo_simul(4,2);
csave(i_rn,i_g) = oo_.endo_simul(3,2);
pisave(i_rn,i_g) = oo_.endo_simul(7,2);
gsave(i_rn,i_g) = oo_.endo_simul(9,2);

subplot(3,3,1)
plot([0:Tfig],400*oo_.endo_simul(2,1:Tfig+1));
title('i')
hold on
subplot(3,3,2)
plot([0:Tfig],400*oo_.endo_simul(1,1:Tfig+1));
title('ni')
hold on
subplot(3,3,3)
plot([0:Tfig],400*oo_.endo_simul(7,1:Tfig+1));
title('pi')
hold on
subplot(3,3,4)
plot([0:Tfig],100*oo_.endo_simul(4,1:Tfig+1));
title('y')
hold on
subplot(3,3,5)
plot([0:Tfig],100*oo_.endo_simul(3,1:Tfig+1));
title('c')
hold on
subplot(3,3,6)
plot([0:Tfig],100*oo_.endo_simul(5,1:Tfig+1));
title('w')
hold on
subplot(3,3,7)
plot([0:Tfig],400*oo_.endo_simul(8,1:Tfig+1));
title('rn')
hold on
subplot(3,3,8)
plot([0:Tfig],100*oo_.endo_simul(9,1:Tfig+1));
title('g')
hold on

end
end

Ym = zeros(1,size(shock_size_rn_vals,2));
Cm = zeros(1,size(shock_size_rn_vals,2));
Pim= zeros(1,size(shock_size_rn_vals,2));

disp('output, consumption, and inflation multipliers (at ELB)')
for i_rn=1:size(shock_size_rn_vals,2)
	[1/GYSS*(ysave(i_rn,2)-ysave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1)) CYSS/GYSS*(csave(i_rn,2)-csave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1)) 1/GYSS*(pisave(i_rn,2)-pisave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1)) ]
	Ym(i_rn)  = 1/GYSS*(ysave(i_rn,2)-ysave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1)); 
	Cm(i_rn)  = CYSS/GYSS*(csave(i_rn,2)-csave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1));
	Pim(i_rn) = 1/GYSS*(pisave(i_rn,2)-pisave(i_rn,1))/(gsave(i_rn,2)-gsave(i_rn,1));
end

figure(2)
subplot(2,2,1)
plot(abs(shock_size_rn_vals),Ym)
subplot(2,2,2)
plot(abs(shock_size_rn_vals),Cm)
subplot(2,2,3)
plot(abs(shock_size_rn_vals),Pim)

%% 図4
figure(4)
plot(abs(shock_size_rn_vals),Ym,'k','LineWidth',1.5)
title('Output multiplier')
xlabel('Size of the demand shock')

