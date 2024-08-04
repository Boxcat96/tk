close all
clear
addpath C:\dynare\5.2\matlab
save_fig=1;

set_params
save params_dynare params
dynare linear_nk_rw
ALPHA_vals = [0 cALPHA1 cALPHA2];
colours=["k","r","b"];

f=figure( 'Units', 'Inches', 'Position', [0, 0, 8, 12]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
Tfig=8;
for ALPHA_val=ALPHA_vals

    set_param_value("cALPHA",ALPHA_val);
    
    perfect_foresight_solver;

    ni=iTR - cALPHA*z;

    subplot(4,2,1)
    plot([0:Tfig],400*i(1:Tfig+1),colours(1),'LineWidth',1.5,'DisplayName',"\alpha="+num2str(ALPHA_val));
    hold on

    subplot(4,2,2)
    plot([0:Tfig],400*ni(1:Tfig+1),colours(1),'LineWidth',1.5);
    hold on

    subplot(4,2,3)
    plot([0:Tfig],400*iTR(1:Tfig+1),colours(1),'LineWidth',1.5);
    hold on

    subplot(4,2,4)
    plot([0:Tfig],400*pi(1:Tfig+1),colours(1),'LineWidth',1.5);
    hold on

    subplot(4,2,5)
    plot([0:Tfig],100*y(1:Tfig+1),colours(1),'LineWidth',1.5);
    hold on

    subplot(4,2,6)
    plot([0:Tfig],[params.cRSTAR*400;400*i(2:Tfig+1)-400*pi(3:Tfig+2)],colours(1),'LineWidth',1.5,'HandleVisibility','off');
    hold on

    subplot(4,2,7.5)
    plot([0:Tfig],400*z(1:Tfig+1),colours(1),'LineWidth',1.5);
    hold on

    colours=colours(2:end);
end
    
subplot(4,2,1)    
yline(params.cRSTAR*400,"--","LineWidth",1.5,"HandleVisibility","off");    
title('政策金利(%)','FontSize',14)
legend('location','northwest')
ylim([0 2.2])
    
subplot(4,2,2)    
yline(params.cRSTAR*400,"--","LineWidth",1.5,"HandleVisibility","off");    
title('影の政策金利(%)','FontSize',14)    
ylim([-inf 2.2])
hold on
    
subplot(4,2,3)    
yline(params.cRSTAR*400,"--","LineWidth",1.5,"HandleVisibility","off");    
title('テイラールール下の政策金利(%)','FontSize',14)    
ylim([-inf 2.2])
hold on

subplot(4,2,4)
yline(0,"--",'Color','#7E2F8E',"LineWidth",1.5,"HandleVisibility","off");    
title('インフレ率(%)','FontSize',14)
ylim([-inf 0.2])
hold on

subplot(4,2,5)
yline(0,"--","LineWidth",1.5,"HandleVisibility","off");        
title('産出ギャップ(%)','FontSize',14)
ylim([-4 0.2])
hold on

subplot(4,2,6)
title('自然利子率・実質金利(%)','FontSize',14);
plot([0:Tfig],rn(1:Tfig+1)*400.',"g","LineStyle","--","LineWidth",1.5,"DisplayName","自然利子率");    
yline(0,"--","LineWidth",1.5,"HandleVisibility","off");  
yline(params.cRSTAR*400,"--","LineWidth",1.5,"HandleVisibility","off");  
ylim([-4.2 2.2]);
legend('location','southeast')
    
subplot(4,2,7.5)
title('Z','FontSize',14)
ylim([-0.1 inf])

if save_fig==1
    saveas(f,"figures\IRF_RW.png")
end
