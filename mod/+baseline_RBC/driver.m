%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'baseline_RBC';
M_.dynare_version = '5.3';
oo_.dynare_version = '5.3';
options_.dynare_version = '5.3';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'epsilon'};
M_.exo_names_tex(1) = {'\varepsilon'};
M_.exo_names_long(1) = {'Productivity shock'};
M_.endo_names = cell(8,1);
M_.endo_names_tex = cell(8,1);
M_.endo_names_long = cell(8,1);
M_.endo_names(1) = {'C'};
M_.endo_names_tex(1) = {'C'};
M_.endo_names_long(1) = {'Consumption'};
M_.endo_names(2) = {'I'};
M_.endo_names_tex(2) = {'I'};
M_.endo_names_long(2) = {'Investment'};
M_.endo_names(3) = {'K'};
M_.endo_names_tex(3) = {'K'};
M_.endo_names_long(3) = {'Capital'};
M_.endo_names(4) = {'L'};
M_.endo_names_tex(4) = {'L'};
M_.endo_names_long(4) = {'Labour'};
M_.endo_names(5) = {'Y'};
M_.endo_names_tex(5) = {'Y'};
M_.endo_names_long(5) = {'Output'};
M_.endo_names(6) = {'R'};
M_.endo_names_tex(6) = {'R'};
M_.endo_names_long(6) = {'Returns'};
M_.endo_names(7) = {'W'};
M_.endo_names_tex(7) = {'W'};
M_.endo_names_long(7) = {'Wages'};
M_.endo_names(8) = {'z'};
M_.endo_names_tex(8) = {'\log(Z)'};
M_.endo_names_long(8) = {'(Log) Productivity'};
M_.endo_partitions = struct();
M_.param_names = cell(7,1);
M_.param_names_tex = cell(7,1);
M_.param_names_long = cell(7,1);
M_.param_names(1) = {'alpha'};
M_.param_names_tex(1) = {'\alpha'};
M_.param_names_long(1) = {'Capital share'};
M_.param_names(2) = {'beta'};
M_.param_names_tex(2) = {'\beta'};
M_.param_names_long(2) = {'Discount rate'};
M_.param_names(3) = {'delta'};
M_.param_names_tex(3) = {'\delta'};
M_.param_names_long(3) = {'Depreciation rate'};
M_.param_names(4) = {'nu'};
M_.param_names_tex(4) = {'\nu'};
M_.param_names_long(4) = {'Labour elasticity'};
M_.param_names(5) = {'rho_z'};
M_.param_names_tex(5) = {'\rho_z'};
M_.param_names_long(5) = {'Persistence of the productivity shock'};
M_.param_names(6) = {'sigma_z'};
M_.param_names_tex(6) = {'\sigma_z'};
M_.param_names_long(6) = {'Standard deviation of the productivity shock'};
M_.param_names(7) = {'xi'};
M_.param_names_tex(7) = {'\xi'};
M_.param_names_long(7) = {'Labour disutility'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 8;
M_.param_nbr = 7;
M_.orig_endo_nbr = 8;
M_.aux_vars = [];
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
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
M_.orig_eq_nbr = 8;
M_.eq_nbr = 8;
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
 0 3 11;
 0 4 0;
 1 5 0;
 0 6 0;
 0 7 0;
 0 8 12;
 0 9 0;
 2 10 0;]';
M_.nstatic = 4;
M_.nfwrd   = 2;
M_.npred   = 2;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 2;
M_.ndynamic   = 4;
M_.dynamic_tmp_nbr = [3; 0; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'Goods market clearing' ;
  2 , 'name' , 'Capital dynamics' ;
  3 , 'name' , 'Production function' ;
  4 , 'name' , 'Productivity process' ;
  5 , 'name' , 'Euler equation' ;
  6 , 'name' , 'Return on capital' ;
  7 , 'name' , 'Wage' ;
  8 , 'name' , 'Labor equation' ;
};
M_.mapping.C.eqidx = [1 5 8 ];
M_.mapping.I.eqidx = [1 2 ];
M_.mapping.K.eqidx = [2 3 6 ];
M_.mapping.L.eqidx = [3 7 8 ];
M_.mapping.Y.eqidx = [1 3 6 7 ];
M_.mapping.R.eqidx = [5 6 ];
M_.mapping.W.eqidx = [7 8 ];
M_.mapping.z.eqidx = [3 4 ];
M_.mapping.epsilon.eqidx = [4 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [3 8 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(8, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(7, 1);
M_.endo_trends = struct('deflator', cell(8, 1), 'log_deflator', cell(8, 1), 'growth_factor', cell(8, 1), 'log_growth_factor', cell(8, 1));
M_.NNZDerivatives = [25; -1; -1; ];
M_.static_tmp_nbr = [3; 0; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(1) = 0.3;
alpha = M_.params(1);
M_.params(2) = 0.99;
beta = M_.params(2);
M_.params(3) = 0.025;
delta = M_.params(3);
M_.params(4) = 2;
nu = M_.params(4);
M_.params(5) = 0.95;
rho_z = M_.params(5);
M_.params(6) = 0.01;
sigma_z = M_.params(6);
M_.params(7) = 4.5;
xi = M_.params(7);
steady;
oo_.dr.eigval = check(M_,options_,oo_);
model_diagnostics(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(6)^2;
options_.irf = 40;
options_.order = 1;
var_list_ = {};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);
write_latex_parameter_table;
write_latex_definitions;


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'baseline_RBC_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
