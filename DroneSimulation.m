function DroneSimulation(states, time, p)
    % DroneSimulation simulates the movement of a drone in 3D space.
    % 
    % states: a matrix the time-history of all drone states.
    % time: a vector containing the times at which the states were
    % calculated
    % p : the parameter values (optional)

    if nargin<3
        p.L=0.243; 
    end

    v = VideoWriter('drone.mp4','MPEG-4');
    open(v);

    % Validate input dimensions
    states=squeeze(states);
    time=squeeze(time);
    time = time(1:9645);
        tf = max(time);
    positions=states(:, 1:3);
    eulerAngles=states(:, 7:9);
    
    disp("Before interp1:");
    disp(size(time))
    disp(size(positions))
    disp(size(eulerAngles))

    assert(size(positions, 2) == 3, 'Positions should be an Nx3 matrix.');
    assert(size(eulerAngles, 2) == 3, 'Euler angles should be an Nx3 matrix.');
    assert(size(positions, 1) == size(eulerAngles, 1), 'Positions and Euler angles should have the same number of rows.');
    figure;
    hold on
    % Initialize the plot

    % Simulate the drone movement
    m=min(positions);
    M=max(positions);
    dt=0.01;
    t=0:dt:max(time);
   

    positions=interp1(time,positions,t);
    eulerAngles=interp1(time,eulerAngles,t);
    numSteps=length(t);
    for i = 1:25:numSteps
        % Extract current position and orientation
        x = positions(i, 1);
        y = positions(i, 2);
        z = positions(i, 3);
        phi = eulerAngles(i, 1);
        theta = eulerAngles(i, 2);
        psi = eulerAngles(i, 3);
        
        % Create rotation matrix from Euler angles
        R = eul2rotm([psi, theta, phi]);
        
        % Draw the drone at the current position
        drawDrone(x, y, z, R, p, m, M)
        plot3(positions(1:4:i, 1), positions(1:4:i, 2), positions(1:4:i, 3), '.','Color', [.7 .7 .7]);
        hold on
         % 
        grid on;
        xlabel('X (meters)');
        ylabel('Y (meters)');
        zlabel('Z (meters)');
        axis([x-2 x+2 y-2 y+2 z-2 z+2])
        title('Drone Movement Simulation');
        view(3);
        axis equal

        axis tight manual
        drawnow
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
    hold off;

    grid on;
    xlabel('X (meters)');
    ylabel('Y (meters)');
    zlabel('Z (meters)');
    axis([m(1) M(1) m(2) M(2) m(3) M(3)])
    title('Drone Movement Simulation');
    view(3);
    axis equal
    text(1,9,9,strcat('Time: ',num2str(tf),' s'),"FontSize",16)
    drawnow
    frame = getframe(gcf);
    writeVideo(v,frame);
    close(v)
end


function drawDrone(x, y, z, R, p, m, M)
    % Draw the drone using patches to represent its realistic shape with beams and rotors
    % Length of the drone arms
    armLength = p.L; % Length of cross arms
    rotorLength = 0.05; % Length of the rotors

    % Define the positions of the drone arms (ends of the cross)
    armPoints = [
        0, 0, 0;     % Center
        armLength, 0, 0; % Right end
        -armLength, 0, 0; % Left end
        0, armLength, 0; % Front end
        0, -armLength, 0; % Back end
    ];

    % Apply rotation to the arm points
    transformedArms = (R * armPoints')' + [x, y, z];

    % Draw the arms
    for i = 2:5
        % Draw each arm as a line
        line([transformedArms(1, 1), transformedArms(i, 1)], ...
             [transformedArms(1, 2), transformedArms(i, 2)], ...
             [transformedArms(1, 3), transformedArms(i, 3)], ...
             'Color', 'b', 'LineWidth', 2);
        hold on
        % Draw rotors at the ends of the arms
        drawRotor(transformedArms(i, :), R, rotorLength);
    end
    
    % Optionally, you can mark the position of the drone
    plot3(x, y, z, 'ro', 'MarkerFaceColor', 'r','MarkerSize',3);
   % axis([m(1) M(1) m(2) M(2) m(3) M(3)])
   view(60,30)
   % axis equal
   
end

function drawRotor(position, R, length)
    % Draw a rotor at a given position using a cylinder
    rotorRadius = 0.1; % Radius of rotors
    [X, Y, Z] = cylinder(rotorRadius, 20); % Cylinder for rotor
    Z(2, :) = length; % Set height of the cylinder

    % Rotate the rotor
    rotorPoints = [X(:) Y(:) Z(:)];
    rotatedRotor = (R * rotorPoints')';

    % Offset rotor to the correct position
    rotatedRotor = rotatedRotor + position; 

    % Draw the rotor
    surf(reshape(rotatedRotor(:, 1), size(X)), ...
         reshape(rotatedRotor(:, 2), size(Y)), ...
         reshape(rotatedRotor(:, 3), size(Z)), ...
         'FaceColor', 'g', 'EdgeColor', 'none', 'FaceAlpha', 0.3);
end

function R = eul2rotm(eulerAngles)
    % Convert Euler angles (phi, theta, psi) to rotation matrix
    phi = eulerAngles(1);  % Roll (x-axis)
    theta = eulerAngles(2); % Pitch (y-axis)
    psi = eulerAngles(3);   % Yaw (z-axis)

    % Rotation matrices around the axes
    R_x = [1          0           0;
           0   cos(phi)  -sin(phi);
           0   sin(phi)   cos(phi)];
    
    R_y = [cos(theta)   0   sin(theta);
           0          1          0;
          -sin(theta)  0   cos(theta)];
    
    R_z = [cos(psi)   -sin(psi)    0;
           sin(psi)    cos(psi)    0;
           0              0          1];

    % Combined rotation matrix
    R = R_z * (R_y * R_x);
end
