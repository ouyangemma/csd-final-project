function derivatives = fcn(states, inputs, parameters)
    % I is the inertia matrix
    I = [parameters.Ixx 0 0;
         0 parameters.Iyy 0;
         0 0 parameters.Izz];

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


    % Derivative of eta is etad
    % Calculative derivatives of etad


    % eta is [phi, theta, psi] = roll pitch yaw
    W = [1  0       -s_pitch;
         0  c_roll  s_phi * c_pitch;
         0 -s_roll  c_roll * c_pitch];
    % v is rpy in body frame
    
    tau_body = [inputs(2);
                inputs(3);
                inputs(4)];
    v = W * etad;
    vd = inv(I) * (tau_body + [(parameters.Iyy - Izz)*v(2)*v(3); ... 
                               (parameters.Izz - Ixx)*v(1)*v(3);
                               (parameters.Ixx - Iyy)*v(1)*v(2)]);
    derivatives = [xid; xidd; etad;vd];
end