function [sys,x0] = energy_bals(t,x,u,flag)
%
%  Simulink interface to TC Lab    
%
% Inputs:    t    - time in [seconds].
%            x    - 4 states, Temperature of Heater 1.
%                   Temperature of Heater 2.
%                   Temperature of Sensor 1.
%                   Temperature of Sensor 2.
%           u(1) = Q1   - Heater 1 level (0-100%)
%           u(2) = Q2   - Heater 2 level (0-100%)
%
% Outputs:   sys and x0 as described in the SIMULINK manual.
%            when flag is 0 sys contains sizes and x0 contains 
%            initial condition. 
%            when flag is 1, sys contains the derivatives,
%            and when flag is 4 sys contains outputs; 
%            y(1)    - Temperature of Heater 1.
%            y(2)    - Temperature of Heater 2.
%            y(3)    - Temperature of Sensor 1.
%            y(4)    - Temperature of Sensor 2.
% Initialize :  define initial conditions,  X0
%               define system in terms of number of states, inputs etc.
%             e.g. sys = [2, 0, 2, 1, 0, 0];
%            1st array :  number of continuous states
%            2nd array :  number of discrete states
%            3rd array :  number of outputs
%            4th array :  number of inputs
%            5th array :  flag for direct feedthrough
%            6th array :  the number of sample times
            


if flag == 0
  % Initialize the system
  x0 = [ 25 25 25 25 ];
  sys = [4, 0, 4, 2, 0, 0];
elseif abs(flag) == 3
  % Return system outputs.
  sys(1,1,1) = x(1);       %  Th1
  sys(2,1,1) = x(2);       %  Th2
  sys(3,1,1) = x(3);       %  Ts1
  sys(4,1,1) = x(4);       %  Ts2
elseif  abs(flag) == 1
  % Return state derivatives.
  sys = energy_bal(t,x,u);
else
  sys = [];  
end