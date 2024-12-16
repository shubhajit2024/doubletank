clc; clear all; close all;
% Define state-space matrices
A = [-0.26, 0.094; 0.094, -0.26];
B = [0.157, 0; 0, 0.157];
C = [1, 0; 0, 1];

% Define desired poles
desired_poles = [-0.8, -0.9];

% Compute feedback gain L
L = place(A, B, desired_poles);

% Compute (A - BL)
A_BL = A - B * L;

% Compute Kr
Kr = inv(C * inv(A_BL) * B);

% Display the gain matrix
disp('State Feedback Gain (L):');
disp(L);
disp('Prefilter Gain (Kr):');
disp(Kr);