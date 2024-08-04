clear
close all
Tfig=25;
T_shock=20;
save_fig=1;
global param;
param.cbeta=0.99;
param.rn=1-param.cbeta;
param.ckappa=0.01;
param.csigma=1;
param.shock_size=0.01;%4% expansionary shock

Ms=[1,0.75,0.5];
colours=["k","r","b"];

%% Only with M=1
f=figure( 'Units', 'Inches', 'Position', [0, 0, 8, 4]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
ind=1;M=Ms(ind);
[ys,is,cpis]=discounted_model_simulation(M,M,M,T_shock);
ys=[0;ys];is=[param.rn;is];cpis=[0;cpis];
subplot(1,2,1)
plot(0:length(ys)-1,ys*100,colours(ind),'LineWidth',1.5);
title("産出ギャップ(%)",'FontSize',14);
legend("$M_{ee,1}=M_{ee,2}=M_{pc}=1$",'location','northeast','interpreter','latex','FontSize',9)

subplot(1,2,2)
plot(0:length(cpis)-1,cpis*400,colours(ind),'LineWidth',1.5);
title("インフレ率(%)",'FontSize',14);


%% 3 different versions of M
f2=figure( 'Units', 'Inches', 'Position', [0, 0, 8, 4]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
ind=1;
for M=Ms
    [ys,is,cpis]=discounted_model_simulation(M,M,M,T_shock);
    ys=[0;ys];is=[param.rn;is];cpis=[0;cpis];
    subplot(1,2,1)
    plot(0:length(ys)-1,ys*100,colours(ind),'LineWidth',1.5);
    hold on

    subplot(1,2,2)
    plot(0:length(cpis)-1,cpis*400,colours(ind),'LineWidth',1.5);
    hold on

    ind=ind+1;
end
subplot(1,2,1)
title("産出ギャップ(%)",'FontSize',14);
legend("$M_{ee,1}=M_{ee,2}=M_{pc}=1$","$M_{ee,1}=M_{ee,2}=M_{pc}=0.75$","$M_{ee,1}=M_{ee,2}=M_{pc}=0.5$",'location','northeast','interpreter','latex','FontSize',9)
subplot(1,2,2)
title("インフレ率(%)",'FontSize',14);
if save_fig==1
    saveas(f,"figures\fg_puzzle1.png");
    saveas(f2,"figures\fg_puzzle2.png");
end