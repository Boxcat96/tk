clear
close all
global params;
set_params_infinite
save_fig=1;
cpis=[];ys=[];rs=[];
stds=linspace(0,0.5/100,30);
irf_std=0.4/100;

for std_rn=stds
    params.std_rn=std_rn;
    discretion_time_iteration
    result=policy(params.crstar,pf);
    cpis=[cpis result.cpis(1)];
    ys=[ys result.ys(1)];
    rs=[rs result.rs(1)];
end

f=figure('Position', [100, 100, 9 * 100, 6 * 100]);
set(gcf, 'Color', 'white'); 
set(gca, 'Color', 'white'); 
subplot(2,2,1)
plot(stds,cpis*400,'k','LineWidth',1.5);
xlabel("\sigma_\epsilon",'FontSize',14)
xline(irf_std,"HandleVisibility","off");
title('インフレ率(%)','FontSize',14);
xlim([0 stds(end)])
box on
grid on

subplot(2,2,2)
plot(stds,ys*100,'k','LineWidth',1.5);
xlabel("\sigma_\epsilon",'FontSize',14)
title('産出ギャップ(%)','FontSize',14);
xlim([0 stds(end)])
xline(irf_std,"HandleVisibility","off");
box on
grid on

subplot(2,2,3.5)
plot(stds,rs*400,'k','LineWidth',1.5);
hold on
yline(params.crstar*400,'k--','LineWidth',1.5);
xlabel("\sigma_\epsilon",'FontSize',14)
title('政策金利(%)','FontSize',14);
xline(irf_std,"HandleVisibility","off");
xlim([0 stds(end)])
box on
grid on
if save_fig==1
saveas(f,"..\figures\ssss.png")
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