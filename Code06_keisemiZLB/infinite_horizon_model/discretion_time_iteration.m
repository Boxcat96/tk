%% 時間反復法＋Christiano and Fisher method、期待値はガウス＝エルミート求積法による
%%ベクトルは全て縦ベクトル
% set_params
global params pf;
%% GH求積法のノード設定
[params.gh_x,params.gh_w]=gausshermite(params.gh_nodes);
params.gh_x=params.std_rn*params.gh_x;

%% 政策関数のグリッド数など
pf.rn_grid_size=150;
rn_lb=params.crstar-5*0.4/100;rn_ub=params.crstar+5*0.4/100;
pf.rn_grids=linspace(rn_lb,rn_ub,pf.rn_grid_size);
pf.cpi_mat=zeros(pf.rn_grid_size,1);
pf.y_mat=zeros(pf.rn_grid_size,1);
pf.r_mat=zeros(pf.rn_grid_size,1)+params.crstar;

%% 政策関数　初期化
pf.cpi_zlb_mat=zeros(pf.rn_grid_size,1);
pf.y_zlb_mat=zeros(pf.rn_grid_size,1);

fnorm=1;
while fnorm>1e-8
    fnorm=0;
    pf.y=griddedInterpolant(pf.rn_grids,pf.y_mat);
    pf.cpi=griddedInterpolant(pf.rn_grids,pf.cpi_mat);
    pf.r=griddedInterpolant(pf.rn_grids,pf.r_mat);
    pf.y_zlb=griddedInterpolant(pf.rn_grids,pf.y_zlb_mat);
    pf.cpi_zlb=griddedInterpolant(pf.rn_grids,pf.cpi_zlb_mat);

    for rn_ind=1:pf.rn_grid_size
        rn=pf.rn_grids(rn_ind);
       %ZLBを無視した場合
       sol=not_binding(rn,pf);
        fnorm=max(fnorm,max(abs([sol.y,sol.cpi,sol.r]-[pf.y_mat(rn_ind),pf.cpi_mat(rn_ind),pf.r_mat(rn_ind)]),[],'all'));
        pf.y_mat(rn_ind)=sol.y;
        pf.cpi_mat(rn_ind)=sol.cpi;
        pf.r_mat(rn_ind)=sol.r;
       %ZLBがかかる場合
       sol=zlb_binding(rn,pf);
        fnorm=max(fnorm,max(abs([sol.y,sol.cpi]-[pf.y_zlb_mat(rn_ind),pf.cpi_zlb_mat(rn_ind)]),[],'all'));
        pf.y_zlb_mat(rn_ind)=sol.y;
        pf.cpi_zlb_mat(rn_ind)=sol.cpi;
    end
%     display("update="+num2str(fnorm));
end

save discretion pf params

function sol=not_binding(node,pf)
    global params;
    rn=node(1);
    rnps=params.crstar+params.crho_rn*(rn-params.crstar)+params.gh_x;
    fvs=policy(rnps,pf);
    ecpip=params.gh_w.'*fvs.cpis;eyp=params.gh_w.'*fvs.ys;
    %yに関する最適条件
    sol.y=-params.ckappa*params.cbeta*ecpip/(params.ckappa^2+params.clambda_y);
    %NKPC
    sol.cpi=params.ckappa*sol.y+params.cbeta*ecpip;
    %オイラー方程式より
    sol.r=ecpip+rn+1/params.csigma*(eyp-sol.y);
end

function sol=zlb_binding(node,pf)
    global params;
    rn=node(1);
    r=0;
    rnps=params.crstar+params.crho_rn*(rn-params.crstar)+params.gh_x;
    fvs=policy(rnps,pf);
    %オイラー方程式より
    sol.y=(params.gh_w.'*fvs.ys)-params.csigma*(r-params.gh_w.'*fvs.cpis-rn);
    %NKPC
    sol.cpi=params.ckappa*sol.y+params.cbeta*params.gh_w.'*fvs.cpis;
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