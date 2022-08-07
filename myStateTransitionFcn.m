% define energy balance model
function dTdt = myStateTransitionFcn(x,u)

%     global Ta k m Cp A As alpha1 alpha2 eps sigma tao ks
    
    % Parameters
    Ta = 27 ;           % °C
    k = 10.0;           % W/m^2-°C
    m = 4.0/1000.0;     % kg
    Cp = 0.5 * 1000.0;  % J/kg-°C    
    A = 10.0 / 100.0^2; % Area in m^2
    As = 2.0 / 100.0^2; % Area in m^2
    alpha1 = 0.0100;    % W / % heater 1
    alpha2 = 0.0050;    % W / % heater 2
    eps = 0.9;          % Emissivity
    sigma = 5.67e-8;    % Stefan-Boltzman
    tao = 20;           % second
    ks = 20;            % W/m^2-°C

    % Nonlinear Energy Balances
    dTh1dt = (1.0/(m*Cp))*(k*A*(Ta-x(1)) + eps * sigma * A * (Ta^4 - x(1)^4) + (ks*As*(x(2)-x(1))) + (eps*sigma*As * (x(2)^4 - x(1)^4) + alpha1*u(1)));
    dTh2dt = (1.0/(m*Cp))*(k*A*(Ta-x(2)) + eps * sigma * A * (Ta^4 - x(1)^4) - (ks*As*(x(2)-x(1))) - (eps*sigma*As * (x(2)^4 - x(1)^4) + alpha2*u(2)));
    dTs1dt = (1.0/tao)*(x(1)-x(3));
    dTs2dt = (1.0/tao)*(x(1)-x(4));
    
    % Output
    dTdt = [dTh1dt,dTh2dt,dTs1dt,dTs2dt]';
end