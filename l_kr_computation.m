clc; close all; clear all;
% Define state-space matrices
A = [-0.26, 0.094; 0.094, -0.26];
B = [0.157, 0; 0, 0.157];
C = [1, 0; 0, 1];
I = eye(2);  % Identity matrix

% Desired pole placement
lambda1 = -0.8;  % First desired pole
lambda2 = -0.9;  % Second desired pole

% Characteristic polynomial coefficients
p1 = -(lambda1 + lambda2);  % Coefficient of s^1
p2 = lambda1 * lambda2;     % Coefficient of s^0

% Desired characteristic polynomial matrix: P(A) = A^2 + p1*A + p2*I
A_squared = A * A;          % Compute A^2
P_A = A_squared + p1 * A + p2 * I;

% Compute controllability matrix R
AB = A * B;                 % Compute A*B
R = [B, AB];                % Controllability matrix

% Extract the first n columns of R to make it square
R_square = R(:, 1:size(A, 1));  % Extract the first n columns of R

% Verify controllability
if rank(R_square) ~= size(A, 1)
    error('The system is not controllable.');
end

% Compute the state feedback gain L using Ackermann's formula
C_c = [1, 0; 0, 1];          % Canonical row vector for controllability
R_inv = inv(R_square);       % Invert the square controllability matrix
L = C_c * R_inv * P_A;       % Apply Ackermann's formula

% Display the state feedback gain
disp('State Feedback Gain (L):');
disp(L);

% Compute A - BL
A_BL = A - B * L;

% Verify eigenvalues of (A - BL) match desired poles
disp('Eigenvalues of A - BL:');
disp(eig(A_BL));

% Compute the prefilter gain K_r
A_BL_inv = inv(A_BL);              % Inverse of (A - BL)
Kr = inv(C * A_BL_inv * B);        % Prefilter gain formula

% Display the prefilter gain
disp('Prefilter Gain (Kr):');
disp(Kr);
