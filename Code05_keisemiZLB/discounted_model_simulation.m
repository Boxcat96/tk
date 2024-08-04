function [ys,is,cpis]=discounted_model_simulation(Mee1,Mee2,Mpc,T_shock)
    global param;
    ys=zeros(T_shock*2,1);is=zeros(T_shock*2,1)+1-param.cbeta;cpis=zeros(T_shock*2,1);
    
    for t=T_shock:-1:1
        if t==T_shock
            i_today=param.rn-param.shock_size;
        else
            i_today=param.rn;
        end
        ys(t)=Mee1*ys(t+1)-param.csigma*(i_today-Mee2*cpis(t+1)-param.rn);
        cpis(t)=param.cbeta*Mpc*cpis(t+1)+param.ckappa*ys(t);
    end
end