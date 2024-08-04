%draw policy function

close all
clear
global params;
set_params
discretion_time_iteration

pfv=policy(pf.rn_grids,pf);
figure()
plot(pf.rn_grids,pfv.ys)
figure()
plot(pf.rn_grids,pfv.rs)
figure()
plot(pf.rn_grids,pfv.cpis*400)

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