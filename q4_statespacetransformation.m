% Define constants
Kh = 2;    % Sensor gain (V/cm)

% Define original state-space matrices
% syms A [2 2] real          % Original state matrix (2x2)
A = [-0.5  0.2;   % Example values for A matrix
      0.1 -0.3];  % Replace with your specific values

% syms B [2 1] real          % Original input matrix (2x1)
B = [0.1;          % Example values for B matrix
     0.05];        % Replace with your specific values

% syms C [1 2] real          % Original output matrix (1x2)
C = [1 0];         % Example values for C matrix
                   % Replace with your specific values

% syms T [2 2] real          % Transformation matrix (2x2)
D = [0];           % Example value for D matrix
                   % Replace with your specific values

% Define the transformation matrix for sensor voltages
% syms Kh real               % Sensor gain (V/cm)
T = [Kh 0; 0 Kh];  % Transformation matrix ; Each state is scaled by the sensor gain Kh

% Compute transformed matrices
A_z = (T * A * inv(T));  % Transformed A matrix
B_z = (T * B);           % Transformed B matrix
C_z = (C * inv(T));      % Transformed C matrix
D_z = D;                         % D matrix remains unchanged

% Display results
disp('Original A matrix:');
disp(A);
disp('Original B matrix:');
disp(B);
disp('Original C matrix:');
disp(C);
disp('Original D matrix:');
disp(D);

disp('Transformed A matrix (A_z):');
disp(A_z);
disp('Transformed B matrix (B_z):');
disp(B_z);
disp('Transformed C matrix (C_z):');
disp(C_z);
disp('Transformed D matrix (D_z):');
disp(D_z);

% Create and display the transformed state-space system
sys_z = ss(double(A_z), double(B_z), double(C_z), double(D_z));
disp('Transformed State-Space System:');
disp(sys_z);
