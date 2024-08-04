%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'linear_nk';
M_.dynare_version = '5.5';
oo_.dynare_version = '5.5';
options_.dynare_version = '5.5';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(2,1);
M_.exo_names_tex = cell(2,1);
M_.exo_names_long = cell(2,1);
M_.exo_names(1) = {'e'};
M_.exo_names_tex(1) = {'e'};
M_.exo_names_long(1) = {'e'};
M_.exo_names(2) = {'e_rn'};
M_.exo_names_tex(2) = {'e\_rn'};
M_.exo_names_long(2) = {'e_rn'};
M_.endo_names = cell(5,1);
M_.endo_names_tex = cell(5,1);
M_.endo_names_long = cell(5,1);
M_.endo_names(1) = {'y'};
M_.endo_names_tex(1) = {'y'};
M_.endo_names_long(1) = {'y'};
M_.endo_names(2) = {'pi'};
M_.endo_names_tex(2) = {'pi'};
M_.endo_names_long(2) = {'pi'};
M_.endo_names(3) = {'i'};
M_.endo_names_tex(3) = {'i'};
M_.endo_names_long(3) = {'i'};
M_.endo_names(4) = {'ni'};
M_.endo_names_tex(4) = {'ni'};
M_.endo_names_long(4) = {'ni'};
M_.endo_names(5) = {'rn'};
M_.endo_names_tex(5) = {'rn'};
M_.endo_names_long(5) = {'rn'};
M_.endo_partitions = struct();
M_.param_names = cell(10,1);
M_.param_names_tex = cell(10,1);
M_.param_names_long = cell(10,1);
M_.param_names(1) = {'cBETA'};
M_.param_names_tex(1) = {'cBETA'};
M_.param_names_long(1) = {'cBETA'};
M_.param_names(2) = {'cSIGMA'};
M_.param_names_tex(2) = {'cSIGMA'};
M_.param_names_long(2) = {'cSIGMA'};
M_.param_names(3) = {'cKAPPA'};
M_.param_names_tex(3) = {'cKAPPA'};
M_.param_names_long(3) = {'cKAPPA'};
M_.param_names(4) = {'cALPHA1'};
M_.param_names_tex(4) = {'cALPHA1'};
M_.param_names_long(4) = {'cALPHA1'};
M_.param_names(5) = {'cALPHA2'};
M_.param_names_tex(5) = {'cALPHA2'};
M_.param_names_long(5) = {'cALPHA2'};
M_.param_names(6) = {'cRELB'};
M_.param_names_tex(6) = {'cRELB'};
M_.param_names_long(6) = {'cRELB'};
M_.param_names(7) = {'cRSTAR'};
M_.param_names_tex(7) = {'cRSTAR'};
M_.param_names_long(7) = {'cRSTAR'};
M_.param_names(8) = {'cPhiPi'};
M_.param_names_tex(8) = {'cPhiPi'};
M_.param_names_long(8) = {'cPhiPi'};
M_.param_names(9) = {'cRhoR'};
M_.param_names_tex(9) = {'cRhoR'};
M_.param_names_long(9) = {'cRhoR'};
M_.param_names(10) = {'shock_size'};
M_.param_names_tex(10) = {'shock\_size'};
M_.param_names_long(10) = {'shock_size'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 5;
M_.param_nbr = 10;
M_.orig_endo_nbr = 5;
M_.aux_vars = [];
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
M_.surprise_shocks = [];
M_.heteroskedastic_shocks.Qvalue_orig = [];
M_.heteroskedastic_shocks.Qscale_orig = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
M_.orig_eq_nbr = 5;
M_.eq_nbr = 5;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 3 8;
 0 4 9;
 0 5 0;
 1 6 0;
 2 7 0;]';
M_.nstatic = 1;
M_.nfwrd   = 2;
M_.npred   = 2;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 2;
M_.ndynamic   = 4;
M_.dynamic_tmp_nbr = [0; 0; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'y' ;
  2 , 'name' , 'pi' ;
  3 , 'name' , 'ni' ;
  4 , 'name' , 'i' ;
  5 , 'name' , 'rn' ;
};
M_.mapping.y.eqidx = [1 2 ];
M_.mapping.pi.eqidx = [1 2 3 ];
M_.mapping.i.eqidx = [1 4 ];
M_.mapping.ni.eqidx = [3 4 ];
M_.mapping.rn.eqidx = [1 5 ];
M_.mapping.e.eqidx = [2 ];
M_.mapping.e_rn.eqidx = [5 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [4 5 ];
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(5, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(10, 1);
M_.endo_trends = struct('deflator', cell(5, 1), 'log_deflator', cell(5, 1), 'growth_factor', cell(5, 1), 'log_growth_factor', cell(5, 1));
M_.NNZDerivatives = [17; -1; -1; ];
M_.static_tmp_nbr = [0; 0; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(1) = 0.9950248756218907;
cBETA = M_.params(1);
M_.params(2) = 1;
cSIGMA = M_.params(2);
M_.params(3) = 0.02;
cKAPPA = M_.params(3);
M_.params(4) = 0;
cALPHA1 = M_.params(4);
M_.params(5) = 0;
cALPHA2 = M_.params(5);
M_.params(6) = 0;
cRELB = M_.params(6);
M_.params(7) = 1-M_.params(1);
cRSTAR = M_.params(7);
M_.params(8) = 2;
cPhiPi = M_.params(8);
M_.params(9) = 0.0;
cRhoR = M_.params(9);
M_.params(10) = (-0.0225);
shock_size = M_.params(10);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(1) = 0;
oo_.steady_state(2) = 0;
oo_.steady_state(3) = M_.params(7);
oo_.steady_state(5) = M_.params(7);
oo_.steady_state(4) = M_.params(7);
oo_.exo_steady_state(1) = 0;
oo_.exo_steady_state(2) = 0;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',2,'multiplicative',0,'periods',1:1,'value',1) ];
M_.exo_det_length = 0;
options_.periods = 100;
perfect_foresight_setup;
perfect_foresight_solver;


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'linear_nk_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
