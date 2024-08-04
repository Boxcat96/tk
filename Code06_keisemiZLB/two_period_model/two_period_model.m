%二期間モデルの計算・図作成
clear
close all
addpath ../
global params
set_params
params.rns=[params.crstar,params.crstar];
params.ckappa=1;
params.cepsilon=params.cepsilon/5;
params.clambda_y=params.ckappa/params.cepsilon;
save_figs=1;
real_interest_rate_legend_on="off";%show legends for the real interest rate if 1 and do not show otherwise
%% Fig1
res1=simulation(0,0.25);
res2=simulation(0.06/4,0.25);
f = figure('Position', [100, 100, 9 * 100, 6 * 100]);
set(gcf, 'Color', 'white');
set(gca, 'Color', 'white');
subplot(2,2,1);
draw_graph_certain(res1.eis,res1.is,"k","on","h=0.0%")
draw_graph_uncertain(res2.eis,res2.is,'r--',"on","h=6.0%")
yline(params.crstar*400,'--','LineWidth',1.5,'HandleVisibility','off');
grid on
box on
legend('location','northwest','FontSize',12);
title("政策金利(%)",'FontSize',14);

subplot(2,2,2);
draw_graph_certain(res1.eys,res1.ys,"k","off","")
draw_graph_uncertain(res2.eys,res2.ys,'r--',"off","")
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
grid on
box on
ylim([-inf 0.2])
title("産出ギャップ(%)",'FontSize',14);

subplot(2,2,3);
draw_graph_certain(res1.ecpis,res1.cpis,"k","off","")
draw_graph_uncertain(res2.ecpis,res2.cpis,'r--',"off","")
yline(0,'--','LineWidth',1.5,'HandleVisibility','off');
grid on
box on
ylim([-inf 0.03])
title("インフレ率(%)",'FontSize',14);

subplot(2,2,4);
draw_graph_certain(res1.ers,res1.rs,"k",real_interest_rate_legend_on,"実質金利(h=0.0%)")
draw_graph_uncertain(res2.ers,res2.rs,'r--',real_interest_rate_legend_on,"実質金利(h=0.0%)")
draw_graph_real_interest_rate(res2.erns,res2.rns,'g:',"on","自然利子率")
yline(params.crstar*400,'--','LineWidth',1.5,'HandleVisibility','off');
grid on
box on
legend('location','northwest','FontSize',12)
title("自然利子率・実質金利(%)",'FontSize',14);
sgtitle("低程度の不確実性の場合")


if save_figs==1
    saveas(f,"..\figures\two_period_model_"+real_interest_rate_legend_on+".png");
end

%% routines
function draw_graph_certain(es,simulations,colour,handle_visibility,lgd)
    plot([1:2],es(1:2),colour,'LineWidth',1.5,'HandleVisibility',handle_visibility,'DisplayName',lgd);
    hold on
    scatter([1:2],es(1:2),32,colour(1),'filled','HandleVisibility','off');
    xticks([1 2])
end

function draw_graph_uncertain(es,simulations,colour,handle_visibility,lgd)
    uncertainty_scatter_markers=['x','x','x'];
    scatter([1],es(1),32,colour(1),'filled','HandleVisibility','off');
    for ind=1:3
        show_legend="on";
        if ind~=1||handle_visibility=="off"
            show_legend="off";
        end
        plot([1:2],simulations(ind,1:2),colour,'LineWidth',1.5,'HandleVisibility',show_legend,'DisplayName',lgd);        
        scatter([2],simulations(ind,2),32,uncertainty_scatter_markers(ind),colour(1),'LineWidth', 2,'HandleVisibility','off');    
    end
    xticks([1 2])
end
function draw_graph_real_interest_rate(es,simulations,colour,handle_visibility,lgd)
    uncertainty_scatter_markers=['x','x','x'];
    scatter([1],es(1),32,colour(1),'filled','HandleVisibility','off');
    for ind=1:3
        show_legend="on";
        if ind~=1||handle_visibility=="off"
            show_legend="off";
        end
        plot([1:2],simulations(ind,1:2),colour,'LineWidth',1.5,'HandleVisibility',show_legend,'DisplayName',lgd);        
        scatter([2],simulations(ind,2),32,uncertainty_scatter_markers(ind),colour(1),'LineWidth', 2,'HandleVisibility','off');    
    end
    xticks([1 2])
end

function results=simulation(h,p)
    global params;
    results.cpis=nan(3,3);results.cpis(:,3)=0;
    results.ys=nan(3,3);results.ys(:,3)=0;
    
    rns=[params.rns;params.rns;params.rns];
    probs=[p;1-2*p;p];

    rns(1,2)=params.rns(2)-h;
    rns(3,2)=params.rns(2)+h;
    for t=2:-1:1
        results.ecpis(t+1)=probs.'*results.cpis(:,t+1);
        results.eys(t+1)=probs.'*results.ys(:,t+1);
        for i=1:3
            results.ys(i,t)=-params.ckappa*params.cbeta/(params.clambda_y+params.ckappa^2)*results.ecpis(t+1);
            results.is(i,t)=1/params.csigma*(results.eys(t+1)-results.ys(i,t))+results.ecpis(t+1)+rns(i,t);
            if results.is(i,t)>=0
                results.cpis(i,t)=params.cbeta*params.clambda_y/(params.clambda_y+params.ckappa^2)*results.ecpis(t+1);
            else
                results.is(i,t)=0;
                results.ys(i,t)=results.eys(t+1)+params.csigma*(results.ecpis(t+1)+rns(i,t));
                results.cpis(i,t)=params.ckappa*results.ys(i,t)+params.cbeta*results.ecpis(t+1);
            end
            results.rs(i,t)=results.is(i,t)-results.ecpis(t+1);
        end
    end
    results.ecpis(1)=probs.'*results.cpis(:,1);
    results.eys(1)=probs.'*results.ys(:,1);
    results.eis=probs.'*results.is;
    results.ers=probs.'*results.rs;
    results.erns=probs.'*rns;

    results.ys=results.ys*100;results.eys=results.eys*100;
    results.cpis=results.cpis*400;results.ecpis=results.ecpis*400;
    results.is=results.is*400;results.eis=results.eis*400;
    results.rs=results.rs*400;results.ers=results.ers*400;
    results.rns=rns*400;results.erns=results.erns*400;
end