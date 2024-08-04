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
V_comm=V;

load("disc_results")
y_disc=y;
pi_disc=pi;
i_disc=i;
rn_disc=rn;
V_disc=V;

f=figure();
set(gcf, 'Color', 'white'); 
set(gca, 'Color', 'white'); 

subplot(2,2,1);
yline(params.cRSTAR*400,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
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
plot([0:Tfig],V_disc(1:Tfig+1),'k','LineWidth',1.5);
hold on
plot([0:Tfig],V_comm(1:Tfig+1),'r','LineWidth',1.5);
xlim([0 Tfig])
title('社会厚生','FontSize',14);
box on

if save_fig==1
    saveas(f,"figures\infinite_horizon.png");
end