%Two-period model with standard and inertial Taylor rules
clear
close all
save_fig=1;
set_params
params.cKAPPA=1;
params.cPhiP=params.cPhiPi;
params.cPhiN=params.cPhiP;

%Standard Taylor rule
is_TR=[0,params.cRSTAR];
[ys_TR,cpis_TR,rs_TR]=two_period_eqm(is_TR,params);
nis_TR=params.cRSTAR+params.cPhiPi*cpis_TR;
ps_TR=[cpis_TR(1),cpis_TR(1)+cpis_TR(2)];
ns_TR=[ps_TR(1)+ys_TR(1),ps_TR(2)+ys_TR(2)];
zs_TR=is_TR-nis_TR;
zs_TR(2)=zs_TR(2)+zs_TR(1);

disp("Checks that the implied i_1 is indeed 0 (not positive)")
%Shadow inertial Taylor rule depending on the past shadow nominal interest rate -1
params.cRhoR=cRhoR1;
ys_iTR1=[1,-(1+params.cSIGMA*params.cKAPPA);
        params.cSIGMA*params.cRhoR*(1-params.cRhoR)*params.cPhiPi*params.cKAPPA,1+params.cSIGMA*(1-params.cRhoR)*params.cPhiPi*params.cKAPPA]\[params.cSIGMA*(params.cRSTAR+params.shock_size);0];
cpis_iTR1=params.cKAPPA*ys_iTR1;
nis_iTR1(1)=params.cRSTAR+(1-params.cRhoR)*params.cPhiPi*cpis_iTR1(1);
nis_iTR1(2)=params.cRSTAR+params.cRhoR*(nis_iTR1(1)-params.cRSTAR)+(1-params.cRhoR)*params.cPhiPi*cpis_iTR1(2);
is_iTR1=[0,nis_iTR1(2)];
rs_iTR1=[-cpis_iTR1(2),is_iTR1(2)];
disp("iTR1 Error: "+num2str(nis_iTR1(1)));%Checks that the implied i_1 is indeed 0 (not positive)


%Shadow inertial Taylor rule depending on the past shadow nominal interest rate -2
params.cRhoR=cRhoR2;
ys_iTR2=[1,-(1+params.cSIGMA*params.cKAPPA);
        params.cSIGMA*params.cRhoR*(1-params.cRhoR)*params.cPhiPi*params.cKAPPA,1+params.cSIGMA*(1-params.cRhoR)*params.cPhiPi*params.cKAPPA]\[params.cSIGMA*(params.cRSTAR+params.shock_size);0];
cpis_iTR2=params.cKAPPA*ys_iTR2;
nis_iTR2(1)=params.cRSTAR+(1-params.cRhoR)*params.cPhiPi*cpis_iTR2(1);
nis_iTR2(2)=params.cRSTAR+params.cRhoR*(nis_iTR2(1)-params.cRSTAR)+(1-params.cRhoR)*params.cPhiPi*cpis_iTR2(2);
is_iTR2=[0,nis_iTR2(2)];
rs_iTR2=[-cpis_iTR2(2),is_iTR2(2)];
disp("iTR2 Error: "+num2str(nis_iTR2(1)))

%Shadow inertial Taylor rule depending on the past actual nominal interest rate -1
params.cRhoR=cRhoR1;
ys_iTR1_actual=[1,-(1+params.cSIGMA*params.cKAPPA);
        0,1+params.cSIGMA*(1-params.cRhoR)*params.cPhiPi*params.cKAPPA]\[params.cSIGMA*(params.cRSTAR+params.shock_size);params.cSIGMA*params.cRhoR*params.cRSTAR];
cpis_iTR1_actual=params.cKAPPA*ys_iTR1_actual;
nis_iTR1_actual(1)=params.cRSTAR+(1-params.cRhoR)*params.cPhiPi*cpis_iTR1_actual(1);
nis_iTR1_actual(2)=params.cRSTAR+params.cRhoR*(0-params.cRSTAR)+(1-params.cRhoR)*params.cPhiPi*cpis_iTR1_actual(2);
is_iTR1_actual=[0,nis_iTR1_actual(2)];
rs_iTR1_actual=[-cpis_iTR1_actual(2),is_iTR1_actual(2)];
disp("iTR1 Error: "+num2str(nis_iTR1_actual(1)));%Checks that the implied i_1 is indeed 0 (not positive)


%PLT
ys_plt(2)=-params.cSIGMA^2*params.cPhiP*(params.cRSTAR+params.shock_size)/(1+params.cSIGMA*params.cPhiP*params.cKAPPA*(2+params.cSIGMA*params.cKAPPA));
cpis_plt(2)=params.cKAPPA*ys_plt(2);
ys_plt(1)=(1+params.cSIGMA*params.cKAPPA)*ys_plt(2)+params.cSIGMA*(params.cRSTAR+params.shock_size);
cpis_plt(1)=params.cKAPPA*ys_plt(1);
is_plt=[0,params.cRSTAR+params.cPhiP*(cpis_plt(1)+cpis_plt(2))];
rs_plt=[-cpis_plt(2),is_plt(2)];
ps_plt=[cpis_plt(1),cpis_plt(1)+cpis_plt(2)];
nis_plt=[params.cRSTAR+params.cPhiP*cpis_plt(1),params.cRSTAR+params.cPhiP*(cpis_plt(1)+cpis_plt(2))];
disp("PLT Error: "+num2str(nis_plt(1)))

%NIT
ys_nit(2)=-params.cSIGMA^2*params.cKAPPA*params.cPhiN*(params.cRSTAR+params.shock_size)/(1+params.cSIGMA*params.cPhiN*(1+2*params.cKAPPA+params.cSIGMA*params.cKAPPA^2));
cpis_nit(2)=params.cKAPPA*ys_nit(2);
ys_nit(1)=(1+params.cSIGMA*params.cKAPPA)*ys_nit(2)+params.cSIGMA*(params.cRSTAR+params.shock_size);
cpis_nit(1)=params.cKAPPA*ys_nit(1);
ns_nit=[cpis_nit(1)+ys_nit(1),cpis_nit(1)+cpis_nit(2)+ys_nit(2)];
is_nit=[0,params.cRSTAR+params.cPhiN*ns_nit(2)];
rs_nit=[-cpis_plt(2),is_nit(2)];
nis_nit=[params.cRSTAR+params.cPhiN*ns_nit(1),params.cRSTAR+params.cPhiN*ns_nit(2)];
disp("NIT Error: "+num2str(nis_nit(1)))

%RW-rule 1
params.cALPHA=cALPHA1;
ys_rw1=[1,-(1+params.cSIGMA*params.cKAPPA);
        params.cSIGMA*params.cALPHA*params.cPhiPi*params.cKAPPA,(1+params.cSIGMA*params.cPhiPi*params.cKAPPA)]\[params.cSIGMA*(params.cRSTAR+params.shock_size);-params.cSIGMA*params.cALPHA*params.cRSTAR];
cpis_rw1=params.cKAPPA*ys_rw1;
nis_rw1(1)=params.cPhiPi*cpis_rw1(1)+params.cRSTAR;
zs_rw1(1)=-nis_rw1(1);
nis_rw1(2)=params.cRSTAR+params.cPhiPi*cpis_rw1(2)-params.cALPHA*zs_rw1(1);
iTR_rw1=params.cPhiPi*cpis_rw1+params.cRSTAR;
is_rw1=[0,nis_rw1(2)];
rs_rw1=[-cpis_rw1(2),is_rw1(2)];
zs_rw1=is_rw1-(params.cRSTAR+params.cPhiPi*cpis_rw1.');
zs_rw1(2)=zs_rw1(2)+zs_rw1(1);

%RW-rule 2
params.cALPHA=cALPHA2;
ys_rw2=[1,-(1+params.cSIGMA*params.cKAPPA);
        params.cSIGMA*params.cALPHA*params.cPhiPi*params.cKAPPA,(1+params.cSIGMA*params.cPhiPi*params.cKAPPA)]\[params.cSIGMA*(params.cRSTAR+params.shock_size);-params.cSIGMA*params.cALPHA*params.cRSTAR];
cpis_rw2=params.cKAPPA*ys_rw2;
nis_rw2(1)=params.cPhiPi*cpis_rw2(1)+params.cRSTAR;
zs_rw2(1)=-nis_rw2(1);
nis_rw2(2)=params.cRSTAR+params.cPhiPi*cpis_rw2(2)-params.cALPHA*zs_rw2(1);
iTR_rw2=params.cPhiPi*cpis_rw2+params.cRSTAR;
is_rw2=[0,nis_rw2(2)];
rs_rw2=[-cpis_rw2(2),is_rw2(2)];
zs_rw2=is_rw2-(params.cRSTAR+params.cPhiPi*cpis_rw2.');
zs_rw2(2)=zs_rw2(2)+zs_rw2(1);

%% Figs for Inertial Taylor rule shadow vs actual
f0=figure('Units', 'Inches', 'Position', [0, 0, 8, 12]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(3,2,1);
plot([1,2],is_TR*400,'k','LineWidth',1.5,'DisplayName','テイラー');
hold on
plot([1,2],is_iTR1_actual*400,'r','LineWidth',1.5,'DisplayName',"慣性付Ⅰ");
plot([1,2],is_iTR1*400,'b','LineWidth',1.5,'DisplayName',"慣性付Ⅱ");
scatter([1,2],is_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],is_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],is_iTR1*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(3,2,2);
plot([1,2],nis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],nis_iTR1_actual*400,'r','LineWidth',1.5);
plot([1,2],nis_iTR1*400,'b','LineWidth',1.5);
scatter([1,2],nis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],nis_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],nis_iTR1*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title("影の政策金利(%)",'FontSize',14);
xticks([1,2])
ylim([-inf 2.2])
grid on

subplot(3,2,3);
plot([1,2],ys_TR*100,'k','LineWidth',1.5);
hold on
plot([1,2],ys_iTR1_actual*100,'r','LineWidth',1.5);
plot([1,2],ys_iTR1*100,'b','LineWidth',1.5);
scatter([1,2],ys_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ys_iTR1_actual*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ys_iTR1*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,4);
plot([1,2],cpis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],cpis_iTR1_actual*400,'r','LineWidth',1.5);
plot([1,2],cpis_iTR1*400,'b','LineWidth',1.5);
scatter([1,2],cpis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],cpis_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],cpis_iTR1*400,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,5.5);
plot([1,2],rs_TR*400,'k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([1,2],rs_iTR1_actual*400,'r','LineWidth',1.5,'HandleVisibility','off');
plot([1,2],rs_iTR1*400,'b','LineWidth',1.5,'HandleVisibility','off');
scatter([1,2],rs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],rs_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],rs_iTR1*400,32,'b','filled','handlevisibility','off');
plot([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,'--','Color','g','LineWidth',1.5,'DisplayName','自然利子率');
scatter([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,32,'g','filled','HandleVisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("自然利子率・実質金利(%)",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-4.1 2.2])
grid on
legend('location','southeast')

f0_2=figure('Units', 'Inches', 'Position', [0, 0, 8, 9]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(2,2,1);
plot([1,2],is_TR*400,'k','LineWidth',1.5,'DisplayName','テイラー');
hold on
plot([1,2],is_iTR1_actual*400,'r','LineWidth',1.5,'DisplayName',"慣性付Ⅰ");
plot([1,2],is_iTR1*400,'b','LineWidth',1.5,'DisplayName',"慣性付Ⅱ");
scatter([1,2],is_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],is_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],is_iTR1*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(2,2,2);
plot([1,2],ys_TR*100,'k','LineWidth',1.5);
hold on
plot([1,2],ys_iTR1_actual*100,'r','LineWidth',1.5);
plot([1,2],ys_iTR1*100,'b','LineWidth',1.5);
scatter([1,2],ys_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ys_iTR1_actual*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ys_iTR1*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(2,2,3);
plot([1,2],cpis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],cpis_iTR1_actual*400,'r','LineWidth',1.5);
plot([1,2],cpis_iTR1*400,'b','LineWidth',1.5);
scatter([1,2],cpis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],cpis_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],cpis_iTR1*400,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(2,2,4);
plot([1,2],rs_TR*400,'k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([1,2],rs_iTR1_actual*400,'r','LineWidth',1.5,'HandleVisibility','off');
plot([1,2],rs_iTR1*400,'b','LineWidth',1.5,'HandleVisibility','off');
scatter([1,2],rs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],rs_iTR1_actual*400,32,'r','filled','handlevisibility','off');
scatter([1,2],rs_iTR1*400,32,'b','filled','handlevisibility','off');
plot([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,'--','Color','g','LineWidth',1.5,'DisplayName','自然利子率');
scatter([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,32,'g','filled','HandleVisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("自然利子率・実質金利(%)",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-4.1 2.2])
grid on
legend('location','southeast')

%% Figs for Inertial Taylor rule
f1=figure('Units', 'Inches', 'Position', [0, 0, 8, 9]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(3,2,1);
plot([1,2],is_TR*400,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],is_iTR1*400,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],is_iTR2*400,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],is_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],is_iTR1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],is_iTR2*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(3,2,2);
plot([1,2],nis_TR*400,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],nis_iTR1*400,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],nis_iTR2*400,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],nis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],nis_iTR1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],nis_iTR2*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title("影の政策金利(%)",'FontSize',14);
xticks([1,2])
ylim([-inf 2.2])
grid on

subplot(3,2,3);
plot([1,2],ys_TR*100,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],ys_iTR1*100,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],ys_iTR2*100,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],ys_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ys_iTR1*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ys_iTR2*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,4);
plot([1,2],cpis_TR*400,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],cpis_iTR1*400,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],cpis_iTR2*400,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],cpis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],cpis_iTR1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],cpis_iTR2*400,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,5.5);
plot([1,2],rs_TR*400,'k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([1,2],rs_iTR1*400,'r','LineWidth',1.5,'HandleVisibility','off');
plot([1,2],rs_iTR2*400,'b','LineWidth',1.5,'HandleVisibility','off');
scatter([1,2],rs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],rs_iTR1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],rs_iTR2*400,32,'b','filled','handlevisibility','off');

plot([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,'--','Color','g','LineWidth',1.5,'DisplayName','自然利子率');
scatter([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,32,'g','filled','HandleVisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("自然利子率・実質金利(%)",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-4.1 2.2])
grid on
legend('location','southeast')

%% PLT and NIT Irfs
f2=figure('Units', 'Inches', 'Position', [0, 0, 8, 9]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(3,2,1);
plot([1,2],is_TR*400,'k','LineWidth',1.5,'DisplayName','テイラー');
hold on
plot([1,2],is_plt*400,'r','LineWidth',1.5,'DisplayName','PLT');
plot([1,2],is_nit*400,'b','LineWidth',1.5,'DisplayName','NIT');
scatter([1,2],is_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],is_plt*400,32,'r','filled','handlevisibility','off');
scatter([1,2],is_nit*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(3,2,2);
plot([1,2],nis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],nis_plt*400,'r','LineWidth',1.5);
plot([1,2],nis_nit*400,'b','LineWidth',1.5);
scatter([1,2],nis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],nis_plt*400,32,'r','filled','handlevisibility','off');
scatter([1,2],nis_nit*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title("影の政策金利(%)",'FontSize',14);
xticks([1,2])
ylim([-inf 2.2])
grid on

subplot(3,2,3);
plot([1,2],ys_TR*100,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],ys_plt*100,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],ys_nit*100,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],ys_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ys_plt*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ys_nit*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,4);
plot([1,2],cpis_TR*400,'k','LineWidth',1.5,'DisplayName','\rho_r=0');
hold on
plot([1,2],cpis_plt*400,'r','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR1));
plot([1,2],cpis_nit*400,'b','LineWidth',1.5,'DisplayName',"\rho_r="+num2str(cRhoR2));
scatter([1,2],cpis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],cpis_plt*400,32,'r','filled','handlevisibility','off');
scatter([1,2],cpis_nit*400,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(3,2,5);
plot([1,2],rs_TR*400,'k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([1,2],rs_plt*400,'r','LineWidth',1.5,'HandleVisibility','off');
plot([1,2],rs_nit*400,'b','LineWidth',1.5,'HandleVisibility','off');
scatter([1,2],rs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],rs_plt*400,32,'r','filled','handlevisibility','off');
scatter([1,2],rs_nit*400,32,'b','filled','handlevisibility','off');
plot([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,'--','Color','g','LineWidth',1.5,'DisplayName','自然利子率');
scatter([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,32,'g','filled','HandleVisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("自然利子率・実質金利(%)",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-4.1 2.2])
grid on
legend('location','southeast')

subplot(3,2,6);
plot([1,2],ps_TR*100,'k','LineWidth',1.5,'DisplayName','テイラー(物価)');
hold on
plot([1,2],ns_TR*100,'k--','LineWidth',1.5,'DisplayName','テイラー(名目所得)');
plot([1,2],ps_plt*100,'r','LineWidth',1.5,'DisplayName','PLT(物価)');
plot([1,2],ns_nit*100,'b--','LineWidth',1.5,'DisplayName','NIT(名目所得)');
scatter([1,2],ps_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ns_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ps_plt*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ns_nit*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("物価・名目所得",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-inf 0.2]);
legend('location','southeast')
grid on

%% Figure for RW
f3=figure('Units', 'Inches', 'Position', [0, 0, 8, 12]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(4,2,1);
plot([1,2],is_TR*400,'k','LineWidth',1.5,'DisplayName','\alpha=0');
hold on
plot([1,2],is_rw1*400,'r','LineWidth',1.5,'DisplayName',"\alpha="+num2str(cALPHA1));
plot([1,2],is_rw2*400,'b','LineWidth',1.5,'DisplayName',"\alpha="+num2str(cALPHA2));
scatter([1,2],is_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],is_rw1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],is_rw2*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(4,2,2);
plot([1,2],nis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],nis_rw1*400,'r','LineWidth',1.5);
plot([1,2],nis_rw2*400,'b','LineWidth',1.5);
scatter([1,2],nis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],nis_rw1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],nis_rw2*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title("影の政策金利(%)",'FontSize',14);
xticks([1,2])
ylim([-inf 2.2])
grid on

subplot(4,2,3);
plot([1,2],nis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],iTR_rw1*400,'r','LineWidth',1.5);
plot([1,2],iTR_rw2*400,'b','LineWidth',1.5);
scatter([1,2],nis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],iTR_rw1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],iTR_rw2*400,32,'b','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
title("テイラールール下の政策金利(%)",'FontSize',14);
xticks([1,2])
ylim([-inf inf])
grid on

subplot(4,2,4);
plot([1,2],ys_TR*100,'k','LineWidth',1.5);
hold on
plot([1,2],ys_rw1*100,'r','LineWidth',1.5);
plot([1,2],ys_rw2*100,'b','LineWidth',1.5);
scatter([1,2],ys_TR*100,32,'k','filled','handlevisibility','off');
scatter([1,2],ys_rw1*100,32,'r','filled','handlevisibility','off');
scatter([1,2],ys_rw2*100,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(4,2,5);
plot([1,2],cpis_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],cpis_rw1*400,'r','LineWidth',1.5);
plot([1,2],cpis_rw2*400,'b','LineWidth',1.5);
scatter([1,2],cpis_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],cpis_rw1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],cpis_rw2*400,32,'b','filled','handlevisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(4,2,6);
plot([1,2],rs_TR*400,'k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([1,2],rs_plt*400,'r','LineWidth',1.5,'HandleVisibility','off');
plot([1,2],rs_nit*400,'b','LineWidth',1.5,'HandleVisibility','off');
scatter([1,2],rs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],rs_plt*400,32,'r','filled','handlevisibility','off');
scatter([1,2],rs_nit*400,32,'b','filled','handlevisibility','off');
plot([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,'--','Color','g','LineWidth',1.5,'DisplayName','自然利子率');
scatter([1,2],[(params.cRSTAR+params.shock_size),params.cRSTAR]*400,32,'g','filled','HandleVisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("自然利子率・実質金利(%)",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
ylim([-4.1 2.2])
grid on
legend('location','southeast')

subplot(4,2,7.5);
zs_TR=[0,zs_TR(1)];
zs_rw1=[0,zs_rw1(1)];
zs_rw2=[0,zs_rw2(1)];
plot([1,2],zs_TR*400,'k','LineWidth',1.5);
hold on
plot([1,2],zs_rw1*400,'r','LineWidth',1.5);
plot([1,2],zs_rw2*400,'b','LineWidth',1.5);
scatter([1,2],zs_TR*400,32,'k','filled','handlevisibility','off');
scatter([1,2],zs_rw1*400,32,'r','filled','handlevisibility','off');
scatter([1,2],zs_rw2*400,32,'b','filled','handlevisibility','off');
title("Z",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
grid on


%% Save Figs
if save_fig==1
    saveas(f0,'figures\FigTwoPeriodItrIrfShadowVsActual.png');
    saveas(f0_2,'figures\FigTwoPeriodItrIrfShadowVsActual2.png');
    saveas(f1,'figures\FigTwoPeriodItrIrf_old.png');
    saveas(f2,'figures\FigTwoPeriodPLTNITIrf.png');
    saveas(f3,'figures\FigTwoPeriodRwTIrf.png');
end

function [ys,cpis,rs]=two_period_eqm(is,params)    
    ys(2)=-params.cSIGMA*(is(2)-params.cRSTAR);
    ys(1)=(1+params.cKAPPA*params.cSIGMA)*ys(2)+params.cSIGMA*(params.cRSTAR+params.shock_size);
    cpis(1)=params.cKAPPA*ys(1);
    cpis(2)=params.cKAPPA*ys(2);
    rs(1)=is(1)-cpis(2);
    rs(2)=is(2);
end