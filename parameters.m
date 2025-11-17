
p.m         = 1.587;    % kg  https://arxiv.org/pdf/2202.07021
p.g         = 9.80665;  % m/s^2; % Acceleration due to gravity

p.A         = 0.0625;   % m^2 
p.rho       = 1.225;    % kg/m^3
p.R         = 0.127;    % m (propeller radius)

p.Ar        = pi*p.R^2;
p.L         = 0.243;    % m      https://arxiv.org/pdf/2202.07021
p.k         = 3.17e-5;  % N-s^2  https://arxiv.org/pdf/2202.07021
p.b         = 7.69e-7;  % N-ms^2 https://arxiv.org/pdf/2202.07021
p.Ixx       = 0.0213;   % kg-m^2 https://arxiv.org/pdf/2202.07021
p.Iyy       = p.Ixx;    % kg-m^2 
p.Izz       = 0.0282;   % kg-m^2 https://arxiv.org/pdf/2202.07021
p.kD        = 0.25;     % kg/s


p.A_lin = [0 0 0   1 0 0           0 0 0   0 0 0;
         0 0 0   0 1 0           0 0 0   0 0 0;
         0 0 0   0 0 1           0 0 0   0 0 0;
         0 0 0   -p.kD/p.m 0 0   0 p.g 0   0 0 0;
         0 0 0   0 -p.kD/p.m 0   -p.g 0 0   0 0 0;
         0 0 0   0 0 -p.kD/p.m   0 0 0   0 0 0;
         0 0 0   0 0 0           0 0 0   1 0 0;
         0 0 0   0 0 0           0 0 0   0 1 0;
         0 0 0   0 0 0           0 0 0   0 0 1;
         0 0 0   0 0 0           0 0 0   0 0 0;
         0 0 0   0 0 0           0 0 0   0 0 0;
         0 0 0   0 0 0           0 0 0   0 0 0];
p.B_lin = [0 0 0 0;
         0 0 0 0;
         0 0 0 0;

         0 0 0 0;
         0 0 0 0;
         1/p.m 0 0 0;

         0 0 0 0;
         0 0 0 0;
         0 0 0 0;

         0 1/p.Ixx 0 0;
         0 0 1/p.Iyy 0;
         0 0 0 1/p.Izz;
         ];



% p.C = [1 1 1 1 1 1 1 1 1 1 1 1];
p.C = eye(12);
F = zeros(6, 12);
F(1:3, 1:3) = eye(3);
F(4:6, 7:9) = eye(3);

% Reference Input

x = 1;
y = 2;
z = 3;
x_d = 0;
y_d = 0;
z_d = 0;
phi = 0;
theta = 0;
psi = 0;
phi_d = 0;
theta_d = 0;
psi_d = 0;

p.ref = [x;y;z;x_d;y_d;z_d;phi;theta;psi;phi_d;theta_d;psi_d];