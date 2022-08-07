% define energy balance model
function dTdt = energy_bal(t,x,u)

    global Ta k m Cp A As alpha1 alpha2 eps sigma tao ks
    
    % Parameters
    Ta = 25 ;           % °C
    k = 10.0;           % W/m^2-°C
    m = 4.0/1000.0;     % kg
    Cp = 0.5 * 1000.0;  % J/kg-°C    
    A = 10.0 / 100.0^2; % Area in m^2
    As = 2 / 100.0^2; % Area in m^2
    alpha1 = 0.0100;    % W / % heater 1
    alpha2 = 0.0075;    % W / % heater 2
    eps = 0.9;          % Emissivity
    sigma = 5.67e-8;    % Stefan-Boltzman
    tao = 20;           % second
    ks = 20;            % W/m^2-°C

    % Temperature States 
    Th1 = x(1);
    Th2 = x(2);
    Ts1 = x(3);
    Ts2 = x(4);
    Q1 = u(1);
    Q2 = u(2);
    

    % Heat Transfer Exchange Between 1 and 2
    conv12 = ks*As*(Th2-Th1);
    rad12  = eps*sigma*As * (Th2^4 - Th1^4);

    % Nonlinear Energy Balances
    dTh1dt = (1.0/(m*Cp))*(k*A*(Ta-Th1) + eps * sigma * A * (Ta^4 - Th1^4) + conv12 + rad12 + alpha1*Q1);
    dTh2dt = (1.0/(m*Cp))*(k*A*(Ta-Th2) + eps * sigma * A * (Ta^4 - Th2^4) - conv12 - rad12 + alpha2*Q2);
    dTs1dt = (1.0/tao)*(Th1-Ts1);
    dTs2dt = (1.0/tao)*(Th2-Ts2);
    
    % Output
    dTdt = [dTh1dt,dTh2dt,dTs1dt,dTs2dt]';
end