% ˜AÚF’‡“c‘×—Suƒ[ƒ‹à—˜§–ñ‰º‚Ì‹à—Z­ôv
% ‘æ2‰ñuƒ[ƒ‹à—˜§–ñ‰º‚Ìà­­ôv
% ŒoƒZƒ~2021”N2E3ŒŽ†ŒfÚ
% }6

% addpath c:/dynare/4.6.1/matlab

addpath c:/dynare/4.6.1/matlab

dynare linear_g noclearall;

cRHOr_vals = [0:0.05:0.95];
%Baseline calibration
shock_size_g_vals = [0.0 0.5];
%Alternative calibration
%shock_size_g_vals = [0.0 1];

NcRHOr=size(cRHOr_vals,2);

adjusted_rn =ones(1,size(cRHOr_vals,2));
nadj=4;

Tfig=30;

cIRFs  = zeros(2*size(cRHOr_vals,2),Tfig+1);
yIRFs  = zeros(2*size(cRHOr_vals,2),Tfig+1);
piIRFs = zeros(2*size(cRHOr_vals,2),Tfig+1);
gIRFs  = zeros(2*size(cRHOr_vals,2),Tfig+1);
iIRFs  = zeros(2*size(cRHOr_vals,2),Tfig+1);
niIRFs = zeros(2*size(cRHOr_vals,2),Tfig+1);

figure(1)

for i_cRHOr=1:size(cRHOr_vals,2)
for i_g=1:size(shock_size_g_vals,2)

% We need thid information to find the right shock size. 
if i_cRHOr==1 && i_g==1
	set_param_value('cRHOr',cRHOr_vals(i_cRHOr));
%Baseline calibration
	set_param_value('cRHOg',0.85);
%Alternative calibration
%	set_param_value('cRHOg',0.3);
	set_param_value('shock_size_g',shock_size_g_vals(i_g));
	perfect_foresight_solver;
	baseline_decline_y=oo_.endo_simul(4,2);
%	baseline_decline_y=oo_.endo_simul(7,2);
%	baseline_decline_y=oo_.endo_simul(3,2);
	adjusted_rn(i_cRHOr)=-0.03;
end

% First, find the right shock size 
if i_g==1 && i_cRHOr>1
	disp('test')
	%Bisection method to find the size of the shock that leads to baseline_decline_y
	set_param_value('shock_size_rn',adjusted_rn(i_cRHOr-1)+0.01);
	set_param_value('cRHOr',cRHOr_vals(i_cRHOr));
	set_param_value('shock_size_g',shock_size_g_vals(i_g));
	perfect_foresight_solver;

	sinit = sign(oo_.endo_simul(4,2)-baseline_decline_y);
%	sinit = sign(oo_.endo_simul(7,2)-baseline_decline_y);
%	sinit = sign(oo_.endo_simul(3,2)-baseline_decline_y);
	rn_max = adjusted_rn(i_cRHOr-1)+0.01;	
	rn_min = adjusted_rn(i_cRHOr-1)-0.01;
	x=(rn_min+rn_max)/2;
	d=(rn_max-rn_min)/2;
	tol=d/1000000;
	ik=0;	
%	while d>tol	
	while ik<20	
		ik=ik+1;
		disp('d')
		disp(d)
		set_param_value('shock_size_rn',x);
		set_param_value('cRHOr',cRHOr_vals(i_cRHOr));
		set_param_value('shock_size_g',shock_size_g_vals(i_g));
		perfect_foresight_solver;
		d=d/2;
        f1=oo_.endo_simul(4,2);
%        f1=oo_.endo_simul(7,2);
%        f1=oo_.endo_simul(3,2);
        f=f1-baseline_decline_y;
		s = sign(f);
		if sinit==s
			x=x-d/2;
		else 
			x=x+d/2;
		end
		disp('x,f,f1,baseline_decline_y')
		disp([x,f,f1,baseline_decline_y])
	end
	adjusted_rn(i_cRHOr)=x;
end

set_param_value('shock_size_rn',adjusted_rn(i_cRHOr));
set_param_value('cRHOr',cRHOr_vals(i_cRHOr));
set_param_value('shock_size_g',shock_size_g_vals(i_g));
perfect_foresight_solver;


%var NR R C Y w N Pi TauH d G;
%varexo A TauC TauN Theta M ed eG;

ysave(i_cRHOr,i_g) = oo_.endo_simul(4,2);
csave(i_cRHOr,i_g) = oo_.endo_simul(3,2);
pisave(i_cRHOr,i_g) = oo_.endo_simul(7,2);
gsave(i_cRHOr,i_g) = oo_.endo_simul(9,2);

cIRFs(i_g+2*(i_cRHOr-1),:)  = 100*oo_.endo_simul(3,1:Tfig+1);
yIRFs(i_g+2*(i_cRHOr-1),:)  = 100*oo_.endo_simul(4,1:Tfig+1);
piIRFs(i_g+2*(i_cRHOr-1),:) = 400*oo_.endo_simul(7,1:Tfig+1);
gIRFs(i_g+2*(i_cRHOr-1),:)  = 100*oo_.endo_simul(9,1:Tfig+1);
iIRFs(i_g+2*(i_cRHOr-1),:)  = 400*oo_.endo_simul(2,1:Tfig+1);
niIRFs(i_g+2*(i_cRHOr-1),:) = 400*oo_.endo_simul(1,1:Tfig+1);


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

Ym = zeros(1,size(cRHOr_vals,2));
Cm = zeros(1,size(cRHOr_vals,2));
Pim= zeros(1,size(cRHOr_vals,2));

disp('output, consumption, and inflation multipliers (at ELB)')
for i_cRHOr=1:size(cRHOr_vals,2)
	[1/GYSS*(ysave(i_cRHOr,2)-ysave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1)) CYSS/GYSS*(csave(i_cRHOr,2)-csave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1)) 1/GYSS*(pisave(i_cRHOr,2)-pisave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1)) ]
	Ym(i_cRHOr)  = 1/GYSS*(ysave(i_cRHOr,2)-ysave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1)); 
	Cm(i_cRHOr)  = CYSS/GYSS*(csave(i_cRHOr,2)-csave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1));
	Pim(i_cRHOr) = 1/GYSS*(pisave(i_cRHOr,2)-pisave(i_cRHOr,1))/(gsave(i_cRHOr,2)-gsave(i_cRHOr,1));
end

figure(2)
subplot(2,2,1)
plot(abs(cRHOr_vals),Ym)
subplot(2,2,2)
plot(abs(cRHOr_vals),Cm)
subplot(2,2,3)
plot(abs(cRHOr_vals),Pim)

%% }6
figure(6)
plot(abs(cRHOr_vals),Ym,'k','LineWidth',1.5)
title('Output multiplier')
xlabel('Size of the demand shock')
xlim([0 0.9])
ylim([0.9 1.2])

