% Figure 2 in Chapter 1.
 addpath c:/dynare/4.6.1/matlab

close all;
T=20;


dynare linear_nk noclearall;

figure(1)

%fontcase = {'b','k','r'};
fontcase = ['b','k','r'];

for it=1:3

if it==1
		set_param_value('cRELB',0/400);
		perfect_foresight_solver;

%var y pi i ni rn;
%varexo e e_rn;

		y_ELB  = 100*oo_.endo_simul(1,1:T);
		pi_ELB = 400*oo_.endo_simul(2,1:T);
		i_ELB  = 400*oo_.endo_simul(3,1:T);
		ni_ELB = 400*oo_.endo_simul(4,1:T);
		rn_ELB = 400*oo_.endo_simul(5,1:T);

		y_ELB1  = y_ELB ;
		pi_ELB1 = pi_ELB;
		i_ELB1  = i_ELB ;

elseif it==2
		set_param_value('cRELB',-0.5/400);
		perfect_foresight_solver;

		y_ELB  = 100*oo_.endo_simul(1,1:T);
		pi_ELB = 400*oo_.endo_simul(2,1:T);
		i_ELB  = 400*oo_.endo_simul(3,1:T);
		ni_ELB = 400*oo_.endo_simul(4,1:T);
		rn_ELB = 400*oo_.endo_simul(5,1:T);

		y_ELB2  = y_ELB ;
		pi_ELB2 = pi_ELB;
		i_ELB2  = i_ELB ;

else
		set_param_value('cRELB',-99);
		perfect_foresight_solver;

		y_ELB  = 100*oo_.endo_simul(1,1:T);
		pi_ELB = 400*oo_.endo_simul(2,1:T);
		i_ELB  = 400*oo_.endo_simul(3,1:T);
		ni_ELB = 400*oo_.endo_simul(4,1:T);
		rn_ELB = 400*oo_.endo_simul(5,1:T);

		y_ELB3  = y_ELB ;
		pi_ELB3 = pi_ELB;
		i_ELB3  = i_ELB ;

end

subplot(2,2,1)
plot([1:T],rn_ELB,fontcase(it));
%plot([1:T],rn_ELB,str(fontcase(it)));
title('自然利子率','FontSize',16)
hold on
subplot(2,2,2)
plot([1:T],i_ELB,fontcase(it));
title('政策金利','FontSize',16)
hold on
subplot(2,2,3)
plot([1:T],pi_ELB,fontcase(it));
title('インフレ率','FontSize',16)
hold on
subplot(2,2,4)
plot([1:T],y_ELB,fontcase(it));
hold on
title('GDP','FontSize',16)
hold on

end

[y_ELB1' ,y_ELB2' ,y_ELB3' ]  
[pi_ELB1',pi_ELB2',pi_ELB3'] 
[i_ELB1' ,i_ELB2' ,i_ELB3' ] 

