// Baseline RBC Model 
// By Rubén Fernández-Fuertes (Bocconi University)
// Implemented on Dynare 5.4 

// VARIABLES:
var
C           $C$             (long_name='Consumption')
I           $I$             (long_name='Investment')
K           $K$             (long_name='Capital')
L           $L$             (long_name='Labour')
Y           $Y$             (long_name='Output')
R           $R$             (long_name='Returns')
W           $W$             (long_name='Wages')
z           $\log(Z)$       (long_name='(Log) Productivity')
;


// EXOGENEOUS SHOCKS:
varexo 
epsilon     $\varepsilon$   (long_name = 'Productivity shock')
;



// PARAMETERS:
parameters
alpha    $\alpha$          (long_name = 'Capital share')
beta     $\beta$           (long_name = 'Discount rate')
delta    $\delta$          (long_name = 'Depreciation rate')
nu       $\nu$             (long_name = 'Labour elasticity')
rho_z    $\rho_z$          (long_name = 'Persistence of the productivity shock')
sigma_z  $\sigma_z$        (long_name = 'Standard deviation of the productivity shock')
xi       $\xi$             (long_name = 'Labour disutility')
;

// PARAMETRISATION
alpha   = 0.3;
beta    = 0.99;
delta   = 0.025;
nu      = 2;
rho_z   = 0.95;
sigma_z = 0.01;
xi      = 4.5;





// MODEL
model;
[name='Goods market clearing']  
Y = C + I;                                                                  // Eq. 4

[name='Capital dynamics']                                                   
K = (1-delta)*K(-1) + I;                                                    // Eq. 5

[name='Production function']
Y = exp(z)*K(-1)^alpha*L^(1-alpha);                                         // Eq. 6

[name='Productivity process']
z = rho_z*z(-1) + epsilon;                                                  // Eq. 7

[name='Euler equation']
1/C = beta/C(+1)*R(+1);                                                     // Eq. 17

[name='Return on capital']
R = alpha*(Y/K(-1)) + (1 - delta);                                          // Eq. 18

[name='Wage']
W = (1-alpha)*(Y/L);                                                        // Eq. 19

[name='Labor equation']
xi*L^(1/nu)*C = W;                                                          // Eq. 20

end;




// STEADY STATES
steady_state_model;
z       = 0;                                                                // Obvious
R       = 1/beta;                                                           // Eq. 27
KtoL    = (alpha/(1/beta-(1-delta)))^(1/(1-alpha));                         // Eq. 29
CtoL    = KtoL^alpha - delta*KtoL;                                          // Eq. 25
W       = (1-alpha)*KtoL^alpha;                                             // Eq. 30          
L       = ((1-alpha)/xi/CtoL*KtoL^alpha)^(nu/(1+nu));                       // Eq. 33
K       = KtoL*L;                
Y       = K^alpha*L^(1-alpha);                                              // Eq. 24
I       = delta*K;                                                          // Eq. 22
C       = Y-I;                                                              // Eq. 23                                           // Definition of KtoL ratio as K/L
end;



steady;
check;
model_diagnostics;



// SHOCKS
shocks;
var epsilon = sigma_z^2;
end;

stoch_simul(order=1,irf=40);

write_latex_original_model;
write_latex_static_model;
write_latex_dynamic_model(write_equation_tags);
write_latex_parameter_table;
write_latex_definitions;
write_latex_steady_state_model;