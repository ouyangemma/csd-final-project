%% 
% LQR

Q = 4* eye(12); % Cost function weighing states
R = 1 * eye([4, 4]); % Cost function weighing inputs
N = 0; % Optional cross term matrix

[K, S, P] = lqr(p.A_lin, p.B_lin, Q, R, N); % K outputs a 4x12 gain matrix

%%%

%% LQE Observer

C = zeros(6,12);
C(1:3,1:3)=eye(3);
C(4:6,7:9)=eye(3);
G = eye(12);
Qw = 0.01 * eye(12);
Qw = Qw + 1e-9 * eye(size(Qw)); % Cost function weighting
Rv = 0.001 * eye(6); % The six input measurement weighting
L = lqr(p.A_lin', C', Qw, Rv)';

%% State Space Observer
Aobs = [p.A_lin-L*C];
Bobs = [p.B_lin L];
Cobs = p.C_obsv;
Dobs = zeros(12);