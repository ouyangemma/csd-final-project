

% LQR

Q = eye(12); % Cost function weighing states
R = eye([4, 4]); % Cost function weighing inputs
N = 0; % Optional cross term matrix

[K, S, P] = lqr(p.A_lin, p.B_lin, Q, R, N);

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

% L = lqr(p.A_lin', C', eye(12), eye(6))';
L = lqr(p.A_lin', C', Qw, Rv)';

%eig(p.A_lin-L*C) 
