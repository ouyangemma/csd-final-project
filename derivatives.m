function derivatives = fcn(states, inputs, parameters)

    xi= states(1:3);
    xid = states(4:6);
    eta = states(7:9);
    etad = states(10:12);

    xidd = [0;0;-parameters.g] + inputs(1)/parameters.m;
    etadd = etad*0;

    derivatives = [xid; xidd; etad;etadd];

    % eta is [phi, theta, psi]
    W = [1 0 -sin(eta[2]);
         0 cos()]
end