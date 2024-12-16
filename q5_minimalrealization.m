% Define system matrices
A = [-0.5  0.2;   % Example A matrix
      0.1 -0.3];  % Replace with specific values
B = [0.1;          % Example B matrix
     0.05];        % Replace with specific values
C = [1 0];         % Example C matrix
                   % Replace with specific values
D = [0];           % Example D matrix

% Compute the controllability matrix
Co = ctrb(A, B);  % MATLAB's built-in controllability function

% Compute the observability matrix
Ob = obsv(A, C);  % MATLAB's built-in observability function

% Check ranks
controllable = rank(Co) == size(A, 1);  % Check if controllable
observable = rank(Ob) == size(A, 1);    % Check if observable

% Display results
disp('Controllability Matrix:');
disp(Co);
if controllable
    disp('The system is controllable.');
else
    disp('The system is not controllable.');
end

disp('Observability Matrix:');
disp(Ob);
if observable
    disp('The system is observable.');
else
    disp('The system is not observable.');
end

% Check minimality
if controllable && observable
    disp('The system is minimal.');
else
    disp('The system is not minimal.');
end
