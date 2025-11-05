function [derivatives_lin, A_lin, B_lin] = derive_lin(states, inputs, p)

    % Angles (roll, pitch, yaw) are small, approx 0
    % sin(x) = x, cos(x) = x 

    % Derivatives are zero
    % No torques (u2 to u4), but do need u1 = mg

    % eta is [phi, theta, psi] = roll pitch yaw
    xi= states(1:3); % x, y, z
    xid = states(4:6); %x_prime, y_prime, z_prime
    eta = states(7:9); % roll, pitch, yaw 
    etad = states(10:12); % roll_prime, pitch_prime, yaw_prime


    % Derivative of xi is xid

    % Calculative derivatives of xid
    % xidd = -(p.kD/p.m)*xid + [eta(2); -eta(1); 0]*p.g + [0;0;1]*inputs(1);
    % Calculative derivatives of etad
    % etadd = inputs
    A_lin = [0 0 0   1 0 0           0 0 0   0 0 0;
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

    B_lin = [0 0 0 0;
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

    derivatives_lin = A * states + B * inputs;
end