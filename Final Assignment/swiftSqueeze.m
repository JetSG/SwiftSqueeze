



%%  SETUP

%Connect lemon to end affector
%collision detection

%singularity if time


%%  Positions
%Positions
lemonStartPos = [0.005, 0.5, 0.775];
lemonOffset = [0, -0.04, 0.008+0.035];
% lemonWidth = 0.035;
% lemonHeight = 0.102;

cuttingBoardPos = [1.160, 0.184, 0.775+0.07]+ lemonOffset;
juicerPos = [1.051, 0.85577, 0.775+0.036];
binPos = [1.33255, 0.85577, 0.775+0.3];

dobotPos = [1.6016, 0.1834, 0.775];
kinovaPos = [0.5434, 0.500, 0.775];


kinovaIdlePos = [1.16, -0.25, 0.8170];


numSteps = 50;

cutEndPos = cuttingBoardPos - [0, 0, 0.05];

cutStartPos = lemonOffset + cuttingBoardPos + [0, 0, 0.1]; 

%%  Object Placement
figure;
workspace = [-3, 3, -5, 2.5, -3, 3];
% axis equal
plotOptions.tile = false;

hold on;

dobot = DobotMagician();
kinova = KinovaLink6();
plotOptions.tile = false;


table = PlaceObject('tableV3.ply', [0 0 0]);

% lemon1 = PlaceObject('lemon1.ply', lemonStartPos);

[f, v, data] = plyread('lemon1.ply', 'tri');

vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
lemon1 = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
hold on;
originalLemonVertices = lemon1.Vertices - [0, 0, 0.07];

lemon1.Vertices = lemon1.Vertices + lemonStartPos;

%lemon2
[f, v, data] = plyread('lemon1.ply', 'tri');

vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
lemon2 = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
hold on;

lemon2.Vertices = lemon2.Vertices + lemonStartPos;

[f, v, data] = plyread('knifeHolder.ply', 'tri');

vertexColors = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
knife = patch('Vertices', v, 'Faces', f, 'FaceVertexCData', vertexColors, 'FaceColor', 'interp', 'EdgeColor', 'none');
hold on;

originalKnifeVert = knife.Vertices;


% lemon1 = PlaceObject('lemon1.ply', cuttingBoardPos);
% lemon2 = PlaceObject('lemon2.ply', cuttingBoardPos);

camlight;

%Dobot Translation

dobot.model.base = transl(dobotPos) * trotz(pi);

dobot.model.animate(dobot.model.getpos());


%KinovaTranslation 

kinova.model.base = transl(kinovaPos);

kinova.model.animate(kinova.model.getpos());

view(3);

%%  MAIN
animateRobot(dobot, numSteps, cutStartPos, 1, knife, originalKnifeVert);


% animateRobot(kinova, numSteps, cuttingBoardPos, trotx(pi)); %move lemon to cutting board
RMRC(kinova, lemonStartPos+[0, 0, 1], pi, 3, 1, 1, 1);
RMRC(kinova, lemonStartPos+[0, 0, 0.07], pi, 1.5, 1, 1, 1);

RMRC(kinova, ((lemonStartPos+cuttingBoardPos)/2)+[0, -0.4, 0.2], pi, 1.5, originalLemonVertices, lemon1, lemon2);

RMRC(kinova, cuttingBoardPos, pi, 1.5, originalLemonVertices, lemon1, lemon2);
RMRC(kinova, kinovaIdlePos, pi, 1.5, 1, 1, 1);


% animateRobot(kinova, numSteps, kinovaIdlePos, trotx(pi)); %move out of the way

animateRobot(dobot, numSteps, cutEndPos, 1, knife, originalKnifeVert);%cut
animateRobot(dobot, numSteps, cutStartPos, 1, knife, originalKnifeVert);%startcutpos
%


% animateRobot(kinova, numSteps, cuttingBoardPos, trotx(pi));%pickup lemon off cuttingboard

RMRC(kinova, cuttingBoardPos, pi, 1.5, 1, 1, 1);
RMRC(kinova, juicerPos+[0, 0, 0.1], pi, 3, originalLemonVertices, lemon1, 1);

% animateRobot(kinova, numSteps, juicerPos+lemonOffset, trotx(pi));%move to juicer
% 
Juice(kinova, numSteps, 2*pi);
Juice(kinova, numSteps, -2*pi);
Juice(kinova, numSteps, 2*pi);
Juice(kinova, numSteps, 0);
% 
% animateRobot(kinova, numSteps, binPos, trotx(pi));%throw lemon in bin
RMRC(kinova, juicerPos+[0, 0, 0.5], pi, 1.5, originalLemonVertices, lemon1, 1);

RMRC(kinova, binPos, pi, 3, originalLemonVertices, lemon1, 1);

for j = 1:20
      lemon1.Vertices = lemon1.Vertices - [0, 0, 0.01];
      pause(0.2);
end

% animateRobot(kinova, numSteps, lemonStartPos, trotx(pi));% go to start
% 

RMRC(kinova, cuttingBoardPos, pi, 1.5, 1, 1, 1);
RMRC(kinova, juicerPos+[0, 0, 0.1], pi, 3, originalLemonVertices, lemon2, 1);

% animateRobot(kinova, numSteps, juicerPos+lemonOffset, trotx(pi));%move to juicer
% 
Juice(kinova, numSteps, 2*pi);
Juice(kinova, numSteps, -2*pi);
Juice(kinova, numSteps, 2*pi);
Juice(kinova, numSteps, 0);
% 
% animateRobot(kinova, numSteps, binPos, trotx(pi));%throw lemon in bin
RMRC(kinova, juicerPos+[0, 0, 0.5], pi, 1.5, originalLemonVertices, lemon2, 1);

RMRC(kinova, binPos, pi, 3, originalLemonVertices, lemon2, 1);

for j = 1:20
      lemon2.Vertices = lemon2.Vertices - [0, 0, 0.01];
      pause(0.2);
end


 

% finalJointStates = ikine(kinova.model.getpos();)

function RMRC(kinova, endPos, pitch, t, originalLemonVertices, lemon, lemon2)
beginPos = transl(kinova.model.fkine(kinova.model.getpos()));
beginX=beginPos(1);
beginY=beginPos(2);
beginZ=beginPos(3);
endX=endPos(1);
endY=endPos(2);
endZ=endPos(3);


    %Set parameters for the simulation
    deltaT = 0.02;      % Control frequency
    steps = t/deltaT;   % No. of steps for simulation
    %deltaa = 2*pi/steps;

    epsilon = 0.1;      % Threshold value for manipulability/Damped Least Squares
    W = diag([1 1 1 0.1 0.1 0.1]);    % Weighting matrix for the velocity vector
    
    %Allocate array data
    m = zeros(steps,1);             % Array for Measure of Manipulability
    qMatrix = zeros(steps,6);       % Array for joint anglesR
    qdot = zeros(steps,6);          % Array for joint velocities
    theta = zeros(3,steps);         % Array for roll-pitch-yaw angles
    x = zeros(3,steps);             % Array for x-y-z trajectory
    
    %Set up trajectory, initial pose
    s = lspb(0,1,steps);                % Trapezoidal trajectory scalar
    for i=1:steps
        
        x(1,i) = (1-s(i))*beginX + s(i)*endX; % Points in x
        % if sina == 1
            x(2,i) = (1-s(i))*beginY + s(i)*endY; % Points in y
        % 
        % else
        %         x(2,i) = beginZ + -0.3*sin(i*5); % Points in z
        % 
        % end
            
            
        x(3,i) = (1-s(i))*beginZ + s(i)*endZ; % Points in z

        
        theta(1,i) = 0;                 % Roll angle 
        theta(2,i) = pitch;            % Pitch angle
        theta(3,i) = 0;                 % Yaw angle
    end
     
    qMatrix(1,:) = kinova.model.getpos();                                            % SET joint for first waypoint %
    
    %Track the trajectory with RMRC
    for i = 1:steps-1
        T = kinova.model.fkine(qMatrix(i,:)).T;                                           % Get forward transformation at current joint state
        deltaX = x(:,i+1) - T(1:3,4);                                         	% Get position error from next waypoint
        Rd = rpy2r(theta(1,i+1),theta(2,i+1),theta(3,i+1));                     % Get next RPY angles, convert to rotation matrix
        Ra = T(1:3,1:3);                                                        % Current end-effector rotation matrix
        Rdot = (1/deltaT)*(Rd - Ra);                                                % Calculate rotation matrix error
        S = Rdot*Ra';                                                           % Skew symmetric!
        linear_velocity = (1/deltaT)*deltaX;
        angular_velocity = [S(3,2);S(1,3);S(2,1)];                              % Check the structure of Skew Symmetric matrix!!
        xdot = W*[linear_velocity;angular_velocity];                          	% Calculate end-effector velocity to reach next waypoint.
        J = kinova.model.jacob0(qMatrix(i,:));                 % Get Jacobian at current joint state
        m(i) = sqrt(det(J*J'));





        if m(i) < epsilon  % If manipulability is less than given threshold
            lambda = (1 - m(i)/epsilon)*5E-2;
        else
            lambda = 0;
        end
        invJ = inv(J'*J + lambda *eye(6))*J';                                   % DLS Inverse
        qdot(i,:) = (invJ*xdot)';                                                % Solve the RMRC equation (you may need to transpose the         vector)
        for j = 1:6                                                             % Loop through joints 1 to 6
            if qMatrix(i,j) + deltaT*qdot(i,j) < kinova.model.qlim(j,1)                     % If next joint angle is lower than joint limit...
                qdot(i,j) = 0; % Stop the motor
            elseif qMatrix(i,j) + deltaT*qdot(i,j) > kinova.model.qlim(j,2)                 % If next joint angle is greater than joint limit ...
                qdot(i,j) = 0; % Stop the motor
            end
        end
        qMatrix(i+1,:) = qMatrix(i,:) + deltaT*qdot(i,:);                         	% Update next joint state based on joint velocities
    end
    
    
    for i = 1:steps
        kinova.model.animate(qMatrix(i,:))

        drawnow();
        if (lemon == 1)

        elseif lemon2 == 1
            lemon.Vertices = originalLemonVertices + transl(kinova.model.fkine(kinova.model.getpos()));
        else
            lemon2.Vertices = originalLemonVertices + transl(kinova.model.fkine(kinova.model.getpos()));
            lemon.Vertices = originalLemonVertices + transl(kinova.model.fkine(kinova.model.getpos()));

        end
    end

    disp('Kinova Joints');
    disp(qMatrix(end,:));
end

function animateRobot(robot, steps, position, angle, knife, originalKnifeVert)
    lemonPosikcon = robot.model.ikcon(transl(position)*angle);
    
    jointTrajectory = jtraj(robot.model.getpos(), lemonPosikcon, steps);
    
    for j = 1:steps
        q = jointTrajectory(j, :); % Get joint configuration for the current step
        robot.model.animate(q); % Animate the robot
        drawnow();
        knife.Vertices =  originalKnifeVert + transl(robot.model.fkine(robot.model.getpos()));


    end
    if length(q) == 5
        disp('Dobot Joints');
        disp(q);
    else
        disp('Kinova Joints');
        disp(q);
    end

end 

function Juice(kinova, steps, spinAngle)
    juiceAim = kinova.model.getpos();

    juiceAim(6) = spinAngle;
        
    jointTrajectory = jtraj(kinova.model.getpos(), juiceAim, steps);
    
    for j = 1:steps
        q = jointTrajectory(j, :); % Get joint configuration for the current step
        kinova.model.animate(q); % Animate the robot
        drawnow();
    end
    if length(q) == 5
        disp('Dobot Joints');
        disp(q);
    else
        disp('Kinova Joints');
        disp(q);
    end
end 
