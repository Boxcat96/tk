clear
close all
global params
set_params
params.rns=[-0.01,0.008,params.crstar];
params.ckappa=1;
params.clambda_y=params.ckappa/params.cepsilon;

fnorm=0;
for h=0.011:0.005:0.02
    for p=0:0.05:0.2
        result_anal=anal(h,p);
        result_simu=simulation(h,p);
        fnorm=max(fnorm,max([max(result_anal.is-result_simu.eis(1:2)),max(result_anal.cpis-result_simu.ecpis(1:2)),max(result_anal.ys-result_simu.eys(1:2))]));
    end
end
display("Error="+num2str(fnorm));

function result=anal(h,p)
    global params;
    r3l=params.rns(3)-h;
    result.is=[nan,nan];
    result.cpis=[nan,nan];
    result.ys=[nan,nan];
    result.is(2)=p*(params.rns(3)-h)*(params.csigma*params.ckappa+1+params.csigma^2*params.cbeta/(params.clambda_y+params.ckappa^2))+params.rns(2);
    result.cpis(2)=params.cbeta*params.clambda_y/(params.clambda_y+params.ckappa^2)*p*params.csigma*params.ckappa*(params.rns(3)-h);
    result.ys(2)=-params.ckappa*params.cbeta/(params.clambda_y+params.ckappa^2)*p*params.csigma*params.ckappa*(params.rns(3)-h);
    if result.is(2)<0
        result.is(2)=0;
        result.cpis(2)=r3l*p*params.csigma*params.ckappa*(1+params.cbeta+params.csigma*params.ckappa)+params.csigma*params.ckappa*params.rns(2);
        result.ys(2)=p*params.csigma*r3l*(1+params.csigma*params.ckappa)+params.csigma*params.rns(2);
        result.is(1)=0;
        result.ys(1)=params.csigma*(p*r3l*(1+params.csigma*params.ckappa+params.csigma*params.ckappa*(1+params.cbeta+params.ckappa*params.csigma))+params.rns(2)*(1+params.csigma*params.ckappa)+params.rns(1));
        result.cpis(1)=p*params.csigma*params.ckappa*r3l*(1+params.csigma*params.ckappa+(params.csigma*params.ckappa+params.cbeta)*(1+params.cbeta+params.csigma*params.ckappa))+params.csigma*params.ckappa*params.rns(2)*(1+params.cbeta+params.csigma*params.ckappa)+params.csigma*params.ckappa*params.rns(1);
    else
        result.is(1)=0;
        result.ys(1)=params.cbeta*params.csigma*params.ckappa*p/(params.clambda_y+params.ckappa^2)*r3l*(-params.ckappa+params.clambda_y*params.csigma)+params.csigma*params.rns(1);
        result.cpis(1)=p*params.csigma*params.ckappa*params.cbeta/(params.clambda_y+params.ckappa^2)*r3l*(-params.ckappa^2+params.clambda_y*params.csigma*params.ckappa+params.cbeta)+params.csigma*params.ckappa*params.rns(1);
    end
end

function results=simulation(h,p)
    global params;
    results.cpis=nan(3,4);results.cpis(:,4)=0;
    results.ys=nan(3,4);results.ys(:,4)=0;
    
    rns=[params.rns;params.rns;params.rns];
    probs=[p;1-2*p;p];

    rns(1,3)=params.rns(3)-h;
    rns(3,3)=params.rns(3)+h;
    for t=3:-1:1
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

%     results.ys=results.ys*100;results.eys=results.eys*100;
%     results.cpis=results.cpis*400;results.ecpis=results.ecpis*400;
%     results.is=results.is*400;results.eis=results.eis*400;
%     results.rs=results.rs*400;results.ers=results.ers*400;
end