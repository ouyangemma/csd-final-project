
function K = drone_controller()

% LQR
Q = eye(12); % Cost function weighing states
R = ones(4,1); % Cost function weighing inputs
N = 0; % Optional cross term matrix

[K, S, P] = lqr(p.A_lin, p.B_lin, Q, R, N);

end

