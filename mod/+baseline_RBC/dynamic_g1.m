function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = baseline_RBC.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(8, 13);
g1(1,3)=(-1);
g1(1,4)=(-1);
g1(1,7)=1;
g1(2,4)=(-1);
g1(2,1)=(-(1-params(3)));
g1(2,5)=1;
g1(3,1)=(-(T(2)*exp(y(10))*getPowerDeriv(y(1),params(1),1)));
g1(3,6)=(-(T(1)*getPowerDeriv(y(6),1-params(1),1)));
g1(3,7)=1;
g1(3,10)=(-(T(1)*T(2)));
g1(4,2)=(-params(5));
g1(4,10)=1;
g1(4,13)=(-1);
g1(5,3)=(-1)/(y(3)*y(3));
g1(5,11)=(-(y(12)*(-params(2))/(y(11)*y(11))));
g1(5,12)=(-(params(2)/y(11)));
g1(6,1)=(-(params(1)*(-y(7))/(y(1)*y(1))));
g1(6,7)=(-(params(1)*1/y(1)));
g1(6,8)=1;
g1(7,6)=(-((1-params(1))*(-y(7))/(y(6)*y(6))));
g1(7,7)=(-((1-params(1))*1/y(6)));
g1(7,9)=1;
g1(8,3)=T(3);
g1(8,6)=y(3)*params(7)*getPowerDeriv(y(6),1/params(4),1);
g1(8,9)=(-1);

end
