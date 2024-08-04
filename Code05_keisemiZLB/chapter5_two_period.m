%A two-period model

clear
close all

set_params
params.cKAPPA=1;
steps=30000;
buffer=0.005;
save_fig=1;
is=0:(params.cRSTAR+buffer)/steps:(params.cRSTAR+buffer);

eqm_matrix=[1,-1,0,-params.cSIGMA;
            0,1,0,0;
            -params.cKAPPA,0,1,0;
            0,-params.cKAPPA,0,1;
            ];

V_1=[];V_2=[];%(Discounted) period utilities in t=1 and 2
y1s=[];y2s=[];%eqm output gap in t=1 and 2
for i=is%nominal interest rate in the 2nd period
    eqm(2)=-params.cSIGMA*(i-params.cRSTAR);
    eqm(1)=(1+params.cKAPPA*params.cSIGMA)*eqm(2)+params.cSIGMA*(params.cRSTAR+params.shock_size);
    eqm(3)=params.cKAPPA*eqm(1);
    eqm(4)=params.cKAPPA*eqm(2);

    y1s=[y1s,eqm(1)];y2s=[y2s,eqm(2)];

    V_1=[V_1,V(eqm(3),eqm(1),params)];
    V_2=[V_2,params.cBETA*V(eqm(4),eqm(2),params)];
end

is=is*400;%annualised nominal interest rate

%MC and MB of reducing i_2
mc=params.cBETA*params.cSIGMA*y2s*(params.cKAPPA^2+params.cLAMBDA);
mb=-params.cSIGMA*(1+params.cSIGMA*params.cKAPPA)*y1s*(params.cKAPPA^2+params.cLAMBDA);

%the optimal i_2 is where mb=mc
optimal_is_candidate=is(mb<=mc);
optimal_i=optimal_is_candidate(end);
eqm_consts=[params.cSIGMA*(params.cRSTAR+params.shock_size);
                -params.cSIGMA*optimal_i/400+params.cSIGMA*params.cRSTAR;
                0;0];
cmt_eqm=eqm_matrix\eqm_consts;%y_1 y_2 pi_1  pi_2
Vs_cmt=Vs(cmt_eqm,params);
%The Markov-perfect eqm
mkv_eqm=[params.cSIGMA*(params.cRSTAR+params.shock_size),0,params.cKAPPA*params.cSIGMA*(params.cRSTAR+params.shock_size),0];%y_1 y_2 pi_1  pi_2
Vs_mkv=Vs(mkv_eqm,params);

%% alternative procedure to find the optimal i_2 as explained in the main text.
%% the value forcmt_eqm2 coincide as the value for "steps" tends toward infinity.

% cmt_eqm2(1)=params.cBETA*params.cSIGMA/(params.cBETA+(1+params.cSIGMA*params.cKAPPA)^2)*(params.cRSTAR+params.shock_size);
% cmt_eqm2(2)=-params.cSIGMA*(1+params.cSIGMA*params.cKAPPA)/(params.cBETA+(1+params.cSIGMA*params.cKAPPA)^2)*(params.cRSTAR+params.shock_size);
% cmt_eqm2(3)=params.cKAPPA*cmt_eqm2(1);
% cmt_eqm2(4)=params.cKAPPA*cmt_eqm2(2);
% 
% optimal_i2=(params.cRSTAR-cmt_eqm2(2)/params.cSIGMA)*400;

%% Create Figures
f2=figure(2);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');

subplot(2,2,1);
plot([1,2],[0,params.cRSTAR*400],'k','LineWidth',1.5,'DisplayName','裁量');
hold on
plot([1,2],[0,optimal_i],'r','LineWidth',1.5,'DisplayName','コミットメント');
scatter([1,2],[0,optimal_i],32,'r','filled','handlevisibility','off');
scatter([1,2],[0,params.cRSTAR*400],32,'k','filled','handlevisibility','off');
yline(params.cRSTAR*400,'--','LineWidth',1.5,'HandleVisibility','off');
ylim([0 2.1]);
title("政策金利(%)",'FontSize',14);
xticks([1,2])
grid on
legend('location','northwest');

subplot(2,2,2);
plot([1,2],[mkv_eqm(1),mkv_eqm(2)]*100,'k','LineWidth',1.5,'DisplayName','裁量');
hold on
plot([1,2],[cmt_eqm(1),cmt_eqm(2)]*100,'r','LineWidth',1.5,'DisplayName','コミットメント');
scatter([1,2],[mkv_eqm(1),mkv_eqm(2)]*100,32,'k','filled','HandleVisibility','off');
scatter([1,2],[cmt_eqm(1),cmt_eqm(2)]*100,32,'r','filled','HandleVisibility','off');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("産出ギャップ(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(2,2,3);
plot([1,2],[mkv_eqm(3),mkv_eqm(4)]*400,'k','LineWidth',1.5,'DisplayName','裁量');
hold on
plot([1,2],[cmt_eqm(3),cmt_eqm(4)]*400,'r','LineWidth',1.5);
scatter([1,2],[mkv_eqm(3),mkv_eqm(4)]*400,32,'k','filled','HandleVisibility','off');
scatter([1,2],[cmt_eqm(3),cmt_eqm(4)]*400,32,'r','filled');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
title("インフレ率(%)",'FontSize',14);
xticks([1,2])
grid on

subplot(2,2,4);
plot([1,2],Vs_mkv,'k','LineWidth',1.5);
hold on
plot([1,2],Vs_cmt,'r','LineWidth',1.5);
scatter([1,2],Vs_mkv,32,'k','filled','HandleVisibility','off');
scatter([1,2],Vs_cmt,32,'r','filled','HandleVisibility','off');
title("社会厚生",'FontSize',14,'HandleVisibility','off');
xticks([1,2])
grid on

if save_fig==1  
    saveas(f2,"figures\two_period.png");
end

function Vs=Vs(eqm,params)
    Vs=nan(1,2);
    Vs(2)=V(eqm(4),eqm(2),params);
    Vs(1)=params.cBETA*Vs(2)+V(eqm(3),eqm(1),params);
end

function V=V(pi,y,params)
    V=-pi^2/2-params.cLAMBDA*y^2/2;
end
