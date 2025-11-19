% LQR

Q = eye(12); % Cost function weighing states
R = eye([4, 4]); % Cost function weighing inputs
N = 0; % Optional cross term matrix

[K, S, P] = lqr(p.A_lin, p.B_lin, Q, R, N); % K outputs a 4x12 gain matrix

%%%

% LQE
%%

C = zeros(6,12);
C(1:3,1:3)=eye(3);
C(4:6,7:9)=eye(3);
G = eye(12);
Qw = 0.01 * eye(12);
Qw = Qw + 1e-9 * eye(size(Qw));
Rv = 0.01 * eye(6);
L = lqr(p.A_lin', C', Qw, Rv)';

%%

Ak = p.A_lin-L * p.C_obsv-p.B_lin * K;
Bk = L;
Ck = K; % 4x12
Dk = 0;
sysK = ss(Ak,Bk,Ck,Dk);

opt = c2dOptions('Method','tustin','ThiranOrder',3);
sysd1 = c2d(sysK,1,opt);
