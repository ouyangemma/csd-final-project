
function control_input = drone_controller(A, B, r, prev_state)

% Linearized Plant A, B given
error = r - prev_state;

% LQR
Q = eye(12); % Cost function weighing states
R = ones(4,1); % Cost function weighing inputs
N = 0; % Optional cross term matrix

[K, S, P] = lqr(sys, Q, R, N);

G1sfu = ss(A-B*K,B,-K,0); % TF: Reference input to control input

t = 0; % Collecting one data point

% u1 : thurst
% u2: torque from roll
% u3: torque from pitch
% u4: torque from yaw
[control_input, tout] = lsim(G1sfu, error, t);

end

