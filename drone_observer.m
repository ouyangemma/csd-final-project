
G = eye(2);
Qw = 0.01 * eye(2);
Rv = 0.01;

C = [0;
    0;
    0;
    1;
    1;
    1;
    0;
    0;
    0;
    1;
    1;
    1;
    ];
L = lqe(p.A_lin,G,p.C,Qw,Rv);