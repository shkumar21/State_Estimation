% Linearized System of Elergy balance equation 
A = [-0.007 0.002 0 0; 0.002 -0.007 0 0; 0.050 0 -0.050 0; 0 0.050 0 -0.050];
B = [0.005 0; 0 0.0038; 0 0; 0 0];
C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
D = zeros(4,2);

% Checking Observability
obsv(A,C);
rank(obsv(A,C));

% Temperature sensor data from TC Lab
% Tsen1 = [transpose(time) transpose(t1s)];
% Tsen2 = [transpose(time) transpose(t2s)];

% Checking Controllability
ctrb(A,B);
rank(ctrb(A,B));


 