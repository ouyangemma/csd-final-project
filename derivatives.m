function derivatives = fcn(states, inputs, parameters)

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
    xidd = zeros(3,1);
    % xidd(1)


    % Calculative derivatives of eta
    % Calculative derivatives of etad


    xidd = [0;0;-parameters.g] + inputs(1)/parameters.m;
    etadd = etad*0;

    derivatives = [xid; xidd; etad;etadd];
end