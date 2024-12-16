% Define symbolic variables
syms h1 h2 u1 u2 real       % State variables (h1, h2) and inputs (u1, u2)
syms Kq a g At K12 h0 u0    % Parameters

% Define nonlinear equations for the double-tank system
q1 = Kq * u1;                         % Pump inflow to Tank 1
q2 = Kq * u2;                         % Pump inflow to Tank 2
q_out1 = a * sqrt(2 * g * h1);        % Outflow from Tank 1
q_out2 = a * sqrt(2 * g * h2);        % Outflow from Tank 2
q_12 = K12 * (h1 - h2);               % Cross-tank flow

% Volume balance equations (nonlinear state equations)
f1 = (1/At) * (q1 - q_out1 - q_12);   % dh1/dt
f2 = (1/At) * (q2 - q_out2 + q_12);   % dh2/dt

% Define the state vector x = [h1; h2] and input vector u = [u1; u2]
x = [h1; h2];
u = [u1; u2];

% Compute Jacobian matrices
A_sym = jacobian([f1; f2], x);        % Partial derivatives of f w.r.t. states
B_sym = jacobian([f1; f2], u);        % Partial derivatives of f w.r.t. inputs

% Substitute operating point (h1 = h2 = h0, u1 = u2 = u0)
operating_point = [h1, h2, u1, u2];
steady_state = [h0, h0, u0, u0];      % Operating point values

% Substitution into Jacobian matrices
A_lin = subs(A_sym, operating_point, steady_state);
B_lin = subs(B_sym, operating_point, steady_state);

% Substitute parameter values
params = [Kq, a, g, At, K12, h0, u0];
param_values = [10, 0.238, 981, 63.6, 6, 14, (0.238/10) * sqrt(2 * 981 * 14)];

A_lin = double(subs(A_lin, params, param_values));
B_lin = double(subs(B_lin, params, param_values));

% Define C and D matrices
C = [1, 0;
     0, 1];  % Output is water levels (h1 and h2)
D = [0, 0;
     0, 0];  % No direct input-output relationship

% Display the results
disp('Linearized State-Space Matrices:');
disp('A Matrix:');
disp(A_lin);
disp('B Matrix:');
disp(B_lin);
disp('C Matrix:');
disp(C);
disp('D Matrix:');
disp(D);

% Create a linearized state-space system in MATLAB
sys_lin = ss(A_lin, B_lin, C, D);

% Display the linearized system
disp('Linearized State-Space System:');
disp(sys_lin);
