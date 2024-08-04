%図４：無限期間　慣性付きテイラールール
close all
clear
addpath C:\dynare\5.2\matlab
save_fig=1;
%Set default value
set_params
params.cRhoR=cRhoR1;%inertial parameter
save params_dynare params

dynare linear_nk_rw;
perfect_foresight_solver;
y_tr=y;
pi_tr=pi;
i_tr=i;
ni_tr=iTR - cALPHA*z;
rt_tr=[params.cRSTAR;(i_tr(2:Tfig+10)-pi_tr(3:Tfig+11))];

dynare linear_nk_inertial_shadow;
y_shadow=y;
pi_shadow=pi;
i_shadow=i;
ni_shadow=ni;
rt_shadow=[params.cRSTAR;(i_shadow(2:Tfig+10)-pi_shadow(3:Tfig+11))];

dynare linear_nk_inertial_actual;
y_actual=y;
pi_actual=pi;
i_actual=i;
ni_actual=ni;
rt_actual=[params.cRSTAR;(i_actual(2:Tfig+10)-pi_actual(3:Tfig+11))];


f=figure( 'Units', 'Inches', 'Position', [0, 0, 8, 12]);
set(gcf, 'Color', 'white'); % figureの背景を透明に設定
set(gca, 'Color', 'white'); % axisの背景を透明に設定

subplot(3,2,1)
h=plot([0:Tfig],400*i_tr(1:Tfig+1),':','DisplayName','テイラールール','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*i_actual(1:Tfig+1),'r','DisplayName','慣性付Ⅰ','LineWidth',1.5);
plot([0:Tfig],400*i_shadow(1:Tfig+1),'b--','DisplayName','慣性付Ⅱ','LineWidth',2);
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title('政策金利(%)','FontSize',14)
ylim([0 2.2])
legend('location','northwest')
uistack(h,'top')

subplot(3,2,2)
plot([0:Tfig],400*ni_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*ni_actual(1:Tfig+1),'r','LineWidth',1.5)
plot([0:Tfig],400*ni_shadow(1:Tfig+1),'b','LineWidth',1.5)
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title('影の政策金利(%)','FontSize',14)
ylim([-inf 2.2])

subplot(3,2,3)
plot([0:Tfig],100*y_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],100*y_actual(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],100*y_shadow(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('生産ギャップ(%)','FontSize',14)
ylim([-inf 0.2])
box on

subplot(3,2,4)
plot([0:Tfig],400*pi_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*pi_actual(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],400*pi_shadow(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('インフレ率(%)','FontSize',14)
ylim([-inf 0.2])
box on

subplot(3,2,5.5)
plot([0:Tfig],400*rt_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3],'HandleVisibility','off');
hold on
plot([0:Tfig],400*rt_actual(1:Tfig+1),'r','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rt_shadow(1:Tfig+1),'b','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rn(1:Tfig+1),'--','Color','g','LineWidth',2,'DisplayName','自然利子率');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([-4.2 2.2])
legend('location','southeast')
title('自然利子率・実質金利(%)','FontSize',14)

f2=figure();
set(gcf, 'Color', 'white'); % figureの背景を透明に設定
set(gca, 'Color', 'white'); % axisの背景を透明に設定

subplot(2,2,1)
h=plot([0:Tfig],400*i_tr(1:Tfig+1),':','DisplayName','テイラールール','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*i_actual(1:Tfig+1),'r','DisplayName','慣性付Ⅰ','LineWidth',1.5);
plot([0:Tfig],400*i_shadow(1:Tfig+1),'b','DisplayName','慣性付Ⅱ','LineWidth',2);
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title('政策金利(%)','FontSize',14)
ylim([0 2.2])
legend('location','northwest')
uistack(h,'top')

subplot(2,2,2)
plot([0:Tfig],100*y_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],100*y_actual(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],100*y_shadow(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('生産ギャップ(%)','FontSize',14)
ylim([-inf 0.2])
box on

% subplot(2,2,2)
% plot([0:Tfig],400*[params.cRSTAR+params.cPhiPi*pi_actual(1:Tfig+1)],'k','DisplayName','バージョン1','LineWidth',1.5);
% hold on
% plot([0:Tfig],400*[params.cRSTAR+params.cPhiPi*pi_shadow(1:Tfig+1)],'r','DisplayName','バージョン2','LineWidth',1.5);
% yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
% title('テイラー・ルール下の政策金利(%)','FontSize',14)

subplot(2,2,3)
plot([0:Tfig],400*pi_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3]);
hold on
plot([0:Tfig],400*pi_actual(1:Tfig+1),'r','LineWidth',1.5);
plot([0:Tfig],400*pi_shadow(1:Tfig+1),'b','LineWidth',1.5);
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title('インフレ率(%)','FontSize',14)
ylim([-inf 0.2])
box on

subplot(2,2,4)
plot([0:Tfig],400*rt_tr(1:Tfig+1),':','LineWidth',3,'Color',[0.3 0.3 0.3],'HandleVisibility','off');
hold on
plot([0:Tfig],400*rt_actual(1:Tfig+1),'r','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rt_shadow(1:Tfig+1),'b','LineWidth',2,'HandleVisibility','off');
plot([0:Tfig],400*rn(1:Tfig+1),'--','Color','g','LineWidth',2,'DisplayName','自然利子率');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([-4.2 2.2])
legend('location','southeast')
title('自然利子率・実質金利(%)','FontSize',14)

if save_fig==1
    saveas(f,"figures\IRF_ITR.png")
    saveas(f2,"figures\IRF_ITR2.png")
end