clear
close all
global params;
set_params_infinite
T=25;
height_buffer=0.1;
save_fig=1;

rns=nan(T+1,1);
rns(1)=params.crstar;
rns(2)=params.crstar-0.02;
for t=2:T
    rns(t+1)=params.crstar+params.crho_rn*(rns(t)-params.crstar);
end

params.std_rn=0/100;%deterministic model
discretion_time_iteration
pf1=pf;
result1=policy(rns,pf1);
result1.rrs=get_rr(rns,pf1);

params.std_rn=0.4/100;%stochastic model
discretion_time_iteration
pf2=pf;
result2=policy(rns,pf2);
result2.rrs=get_rr(rns,pf2);

f = figure('Position', [100, 100, 9 * 100, 6 * 100]);
set(gcf, 'Color', 'white'); 
set(gca, 'Color', 'white'); 
subplot(2,2,1);
yline(params.crstar*400,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
yline(0,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
plot([0:T],400*result1.rs,'k','LineWidth',1.5,'DisplayName','\sigma_\epsilon=0');
plot([0:T],400*result2.rs,'r','LineWidth',1.5,'DisplayName','\sigma_\epsilon=0.4/100');
xlim([0 T])
ylim([400*min([result1.rs;result2.rs])-height_buffer,400*max([result1.rs;result2.rs])+height_buffer])
title('政策金利(%)','FontSize',14)
legend('location','southeast')
box on

subplot(2,2,2);
yline(0,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:T],100*result1.ys,'k','LineWidth',1.5);
plot([0:T],100*result2.ys,'r','LineWidth',1.5);
xlim([0 T]);
ylim([100*min([result1.ys;result2.ys])-height_buffer,100*max([result1.ys;result2.ys])+height_buffer]);
title('産出ギャップ(%)','FontSize',14)
box on

subplot(2,2,3);
yline(0,'--','Color','k','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:T],400*result1.cpis,'k','LineWidth',1.5);
plot([0:T],400*result2.cpis,'r','LineWidth',1.5);
xlim([0 T])
ylim([400*min([result1.cpis;result2.cpis])-height_buffer 400*max([result1.cpis;result2.cpis])+height_buffer])
title('インフレ率(%)','FontSize',14);
box on

subplot(2,2,4);
yline(params.crstar*400,'--','LineWidth',1.5,'HandleVisibility','off');
hold on
plot([0:T],400*result1.rrs,'k','LineWidth',1.5,'HandleVisibility','off');
plot([0:T],400*result2.rrs,'r','LineWidth',1.5,'HandleVisibility','off');
plot([0:T],400*rns,'g--','LineWidth',1.5,'DisplayName','自然利子率');
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
xlim([0 T])
ylim([-4-height_buffer params.crstar*400+height_buffer*2])
title('自然利子率・実質金利(%)','FontSize',14);
legend('location','southeast')
box on

if save_fig==1
saveas(f,"..\figures\irf.png");
end
function rr_path=get_rr(rns,pf)
    global params;
    rr_path=nan(length(rns),1);
    for t=1:length(rns)
        rnps=params.crstar+params.crho_rn*(rns(t)-params.crstar)+params.gh_x;
        ecpip=params.gh_w.'*(policy(rnps,pf).cpis);
        r=policy(rns(t),pf).rs;
        rr_path(t)=r-ecpip;
    end
end

function pfv=policy(rns,pf)
    pfv.ys=nan(length(rns),1);
    pfv.cpis=nan(length(rns),1);
    pfv.rs=nan(length(rns),1);
    for rn_ind=1:length(rns)
        rn=rns(rn_ind);
        if pf.r(rn)>=0
            pfv.ys(rn_ind)=pf.y(rn);
            pfv.cpis(rn_ind)=pf.cpi(rn);
            pfv.rs(rn_ind)=pf.r(rn);
        else
            pfv.ys(rn_ind)=pf.y_zlb(rn);
            pfv.cpis(rn_ind)=pf.cpi_zlb(rn);
            pfv.rs(rn_ind)=0;
        end
    end
end