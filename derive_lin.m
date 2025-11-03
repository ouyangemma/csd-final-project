function derivatives_linearized = derive_lin(states, inputs, parameters)

    % Angles (roll, pitch, yaw) are small, approx 0
    % sin(x) = x, cos(x) = x 

    % Derivatives are zero
    % No torques (u2 to u4), but do need u1 = mg

    xi= states(1:3); % x, y, z
    xid = states(4:6); %x_prime, y_prime, z_prime
    eta = states(7:9); % roll, pitch, yaw
    etad = states(10:12); % roll_prime, pitch_prime, yaw_prime

    % Cosines of each
    c_roll = cos(eta(1));
    c_pitch = cos(eta(2));
    c_yaw = cos(eta(3));

    % Sines of each
    s_roll = sin(eta(1));
    s_pitch = sin(eta(2));
    s_yaw = sin(eta(3));


    % Derivative of xi is xid

    % Calculative derivatives of xid
    xidd = [0;0;-p.g] - (p.kD/p.m)*xid + ...
        [s_roll*s_yaw + c_roll*s_pitch*c_yaw;
         c_roll*s_pitch*s_yaw - s_roll*c_yaw;
         c_roll*c_pitch]*inputs(1);


    % Calculative derivatives of eta
    % Calculative derivatives of etad

    derivatives = [xid; xidd; etad;etadd];
end