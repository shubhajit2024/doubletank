clc; close all; clear all;
% A matrix
%------------------------
A = [-0.1165  0.0943;   
      0.0943 -0.1165]; 
disp("A Matrix:");
disp(A);
% B matrix
%------------------------
B = [0.1572 0;          
     0 0.1572];
disp("B Matrix:");
disp(B);
%  C matrix
%------------------------
C = [1 0;
     0 1];
disp("C Matrix:");
disp(C);
% D matrix
%------------------------
D = [0 0;
     0 0];
disp("D Matrix:");
disp(D);
% Calculate Poles
% ----------------------
syms s
I = eye(size(A));  % Identity matrix
char_eq = det(s * I - A);  % Characteristic equation

% Expand the characteristic equation
%char_eq = (simplify(char_eq);
%disp('Characteristic Equation:');
%disp(char_eq);

% Solve for the poles
%------------------------
poles = double(solve(char_eq == 0, s));
disp('Poles of the System:');
disp(poles);

% Stability Conditions
% ----------------------
if all(real(poles) < 0)
    disp('Therefore, system is asymptotically stable (all poles have negative real parts).');
elseif any(real(poles) > 0)
    disp('Therefore, system is unstable (at least one pole has a positive real part).');
elseif all(real(poles) == 0)
    disp('Therefore, system is marginally stable (all poles are on the imaginary axis).');
else
    disp('The system stability is indeterminate.');
end

% Calculate Zeros
% -----------------------
% Form the augmented matrix [sI - A, -B; C, D]
augmented_matrix = [s * I - A, -B; C, D];

% Compute the determinant of the augmented matrix
%------------------------
zero_eq = det(augmented_matrix);

% Expand the determinant equation
%zero_eq = simplify(zero_eq);
%disp('Zero Equation:');
%disp(zero_eq);

% Solve for the zeros
%------------------------
disp('Zeros of the System (Numerical):');
if isempty(zeros)
    disp('No zeros exist for this system.');
else
    disp(zeros);
    display('Therefore, System in Non-minimum phase.')
end

% Compute the controllability matrix
%------------------------
Co = ctrb(A, B);  % MATLAB's built-in controllability function

% Compute the observability matrix
%------------------------
Ob = obsv(A, C);  % MATLAB's built-in observability function

% Check ranks
%------------------------
controllable = rank(Co) == size(A, 1);  % Check if controllable
observable = rank(Ob) == size(A, 1);    % Check if observable

% Display results
%------------------------
disp('Controllability Matrix:');
disp(Co);
if controllable
    disp('Therefore, system is controllable.');
else
    disp('Therefore, system is not controllable.');
end

disp('Observability Matrix:');
disp(Ob);
if observable
    disp('Therefore, system is observable.');
else
    disp('Therefore, system is not observable.');
end

% Check minimality
%------------------------
if controllable && observable
    disp('Therefore, system is minimal.');
else
    disp('Therefore, system is not minimal.');
end

% Store poles in variables
%------------------------
pole1 = -120%poles(1); % -0.2108
pole2 = -56%poles(2); % -0.0222

% Desired Characteristic Polynomial
% ----------------------
% The desired characteristic equation is:
% P(s) = s^2 + (pole1 + pole2) * s + (pole1 * pole2)
p1 = pole1 + pole2;  % Coefficient of s
p2 = pole1 * pole2;  % Constant term

disp('Desired Characteristic Polynomial Coefficients:');
disp(['p1 (s coefficient): ', num2str(p1)]);
disp(['p2 (constant term): ', num2str(p2)]);

% Desired Characteristic Polynomial Matrix P(A)
P_A = A^2 + p1 * A + p2 * I;
disp('Desired Characteristic Polynomial Matrix (P(A)):');
disp(P_A);

% Compute the Controllability Matrix
% ----------------------
% Co = [B A*B]
Co = [B, A * B];
disp('Controllability Matrix (Co):');
disp(Co);

% Compute the Moore-Penrose Pseudoinverse of Co
% ----------------------
% Co_pseudo_inverse = (Co^T * Co)^-1 * Co^T
Co_T = Co';  % Transpose of controllability matrix
Co_pseudo_inverse = inv(Co_T * Co) * Co_T;
disp('Moore-Penrose Pseudoinverse of Controllability Matrix:');
disp(Co_pseudo_inverse);

% Feedback Gain Matrix
% ----------------------
% Formula: [0 1 0 0] * Co_pseudo_inverse * P(A)
control_row_vector = [0 1 0 0];  % 1x4 row vector
Feedback_Gain = control_row_vector * Co_pseudo_inverse * P_A;
disp('Feedback Gain Matrix (L):');
disp(Feedback_Gain);