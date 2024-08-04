close all
clear
addpath C:\dynare\5.2\matlab
save_fig=1;
%Set default value
set_params
save params_dynare params

%cALPHA=0 is equivalent to a simple Taylor rule
dynare linear_nk_rw;
perfect_foresight_solver;
y_tr=y;
pi_tr=pi;
i_tr=i;
ni_tr=iTR;
n_tr=p+y;
p_tr=p;
rt_tr=[params.cRSTAR;(i_tr(2:Tfig+10)-pi_tr(3:Tfig+11))];

dynare linear_nk_plt;
y_plt=y;
pi_plt=pi;
i_plt=i;
ni_plt=ni;
n_plt=p+y;
p_plt=p;
rt_plt=[params.cRSTAR;(i_plt(2:Tfig+10)-pi_plt(3:Tfig+11))];

dynare linear_nk_nit;
y_nit=y;
pi_nit=pi;
i_nit=i;
ni_nit=ni;
n_nit=p+y;
p_nit=p;
rt_nit=[params.cRSTAR;(i_nit(2:Tfig+10)-pi_nit(3:Tfig+11))];

f=figure( 'Units', 'Inches', 'Position', [0, 0, 8, 9]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');

subplot(3,2,1)
h=plot([0:Tfig],400*i_tr(1:Tfig+1),':','DisplayName','テイラールール','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*i_plt(1:Tfig+1),'r','DisplayName','PLT','LineWidth',1.5);
plot([0:Tfig],400*i_nit(1:Tfig+1),'b','DisplayName','NIT','LineWidth',2);
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
legend('location','northwest')
uistack(h,'top')
ylim([0 2.2])
title('政策金利(%)','FontSize',14)
box on

subplot(3,2,2)
plot([0:Tfig],400*ni_tr(1:Tfig+1),':','DisplayName','テイラールール','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*ni_plt(1:Tfig+1),'r','DisplayName','PLT','LineWidth',1.5);
plot([0:Tfig],400*ni_nit(1:Tfig+1),'b','DisplayName','NIT','LineWidth',1.5);
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title('影の政策金利(%)','FontSize',14)
box on


subplot(3,2,3)
plot([0:Tfig],100*y_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],100*y_plt(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],100*y_nit(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('産出ギャップ(%)','FontSize',14)
ylim([-inf 0.2])
box on

subplot(3,2,4)
plot([0:Tfig],400*pi_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*pi_plt(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],400*pi_nit(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('インフレ率(%)','FontSize',14)
ylim([-inf 0.2])
box on

subplot(3,2,5)
plot([0:Tfig],400*rt_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3],'HandleVisibility','off');
hold on
plot([0:Tfig],400*rt_plt(1:Tfig+1),'r','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rt_nit(1:Tfig+1),'b','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rn(1:Tfig+1),'--','Color','g','LineWidth',2,'DisplayName','自然利子率');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([-4.2 2.2])
legend('location','southeast')
title('自然利子率・実質金利(%)','FontSize',14)


subplot(3,2,6)
plot([0:Tfig],100*p_tr(1:Tfig+1),'k','LineWidth',2,'DisplayName','テイラールール(物価)');
hold on
plot([0:Tfig],100*n_tr(1:Tfig+1),'k--','LineWidth',2,'DisplayName','テイラールール(名目所得)');
plot([0:Tfig],100*p_plt(1:Tfig+1),'r','LineWidth',2,'DisplayName','PLT(物価)');
plot([0:Tfig],100*n_nit(1:Tfig+1),'b--','LineWidth',2,'DisplayName','NIT(名目所得)');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([-inf 0.2]);
legend('location','southeast')
title('物価・名目所得','FontSize',14)

if save_fig==1
    saveas(f,"IRF_PLT-NIT.png");
end