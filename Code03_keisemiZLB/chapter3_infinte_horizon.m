%Hiro Endo
%Taisuke Nakata	taisuke.nakata@e.u-tokyo.ac.jp

%A comparison btw optimal commitment and discretionary policies in an
%infinite horizon NK model with ELB(=ZLB in this case)
addpath C:\dynare\5.2\matlab
clear
close all
save_fig=1;
set_params
save params_dynare params

dynare comm_dynare.mod
dynare disc_dynare.mod

Tfig=10;
height_buffer=0.1;
%Load results
load("comm_results")
y_comm=y;
pi_comm=pi;
i_comm=i;
rn_comm=rn;

load("disc_results")
y_disc=y;
pi_disc=pi;
i_disc=i;
rn_disc=rn;

f=figure();
set(gcf, 'Color', 'white'); 
set(gca, 'Color', 'white'); 

subplot(2,2,1);
yline(params.cRSTAR*400,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
% yline(params.cRELB*400,':','Color','k','LineWidth',1.5,'DisplayName','ゼロ金利制約','HandleVisibility','off');
plot([0:Tfig],400*i_disc(1:Tfig+1),'k','LineWidth',1.5,'DisplayName','裁量');
plot([0:Tfig],400*i_comm(1:Tfig+1),'r','LineWidth',1.5,'DisplayName','コミットメント');
xlim([0 Tfig])
ylim([400*min([i_comm;i_disc])-height_buffer,400*max([i_comm;i_disc])+height_buffer])
title('政策金利(%)','FontSize',14)
legend('location','best')
box on

subplot(2,2,2);
yline(0,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:Tfig],100*y_disc(1:Tfig+1),'k','LineWidth',1.5);
plot([0:Tfig],100*y_comm(1:Tfig+1),'r','LineWidth',1.5);
xlim([0 Tfig])
ylim([100*min([y_comm;y_disc])-height_buffer,100*max([y_comm;y_disc])+height_buffer])
title('産出ギャップ(%)','FontSize',14)
box on

subplot(2,2,3);
yline(0,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:Tfig],400*pi_disc(1:Tfig+1),'k','LineWidth',1.5);
plot([0:Tfig],400*pi_comm(1:Tfig+1),'r','LineWidth',1.5);
xlim([0 Tfig])
ylim([400*min([pi_comm;pi_disc])-height_buffer 400*max([pi_comm;pi_disc])+height_buffer])
title('インフレ率(%)','FontSize',14);
box on

subplot(2,2,4);
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:Tfig],[params.cRSTAR*400;400*(i_disc(2:Tfig+1)-pi_disc(3:Tfig+2))],'k','LineWidth',1.5,'DisplayName','実質金利(裁量)');
plot([0:Tfig],[params.cRSTAR*400;400*(i_comm(2:Tfig+1)-pi_comm(3:Tfig+2))],'r','LineWidth',1.5,'DisplayName','実質金利(コミットメント)');
plot([0:Tfig],400*rn_comm(1:Tfig+1),'--','Color','b','LineWidth',1.5,'DisplayName','自然利子率');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
xlim([0 Tfig])
ylim([-4.3 2.3])
title('自然利子率・実質金利(%)','FontSize',14);
legend('location','best')
box on

if save_fig==1
    saveas(f,"FigInfiniteHorizon.png");
%    saveas(f,"***your path***");
end